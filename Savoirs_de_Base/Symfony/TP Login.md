# TP Live coding - Page de login dans Symfony 7.4

## Objectif

À la fin du TP, on obtient :

- une **page de login** fonctionnelle (formulaire Twig)

- une authentification via l’email + mot de passe (hash en base)

- un **logout**

- une protection d’URLs (ex: `/admin`) qui redirige automatiquement vers le login

- une base saine pour ajouter ensuite: remember me, inscription, reset password, etc.

---

## Pré-requis

On part du principe que :

- l’entité `User` existe déjà (avec `email`, `roles`, `password`)

- la table `user` est bien en base (migrations OK)

- on a déjà au moins **1 utilisateur** en base (via la commande `app:create-user` du TP précédent)

- Twig est disponible (sinon voir étape 1)

---

## 1) Installer ce qu’il faut (si besoin)

### 1.1 Vérifier Twig

Si des vues Twig existent déjà, on peut sauter.

Sinon :

```bash
composer require symfony/twig-bundle
composer require symfony/asset
```

### Explication

- `twig-bundle` permet d’avoir des templates `.html.twig`

- `asset` aide à gérer CSS/JS/images proprement

---

## 2) Générer l’authentification (login/logout) avec Maker

### Commande

```bash
php bin/console make:security:form-login
```

### Choix conseillés dans l’assistant

- **What style of authentication do you want?**
  
  - `Login form authenticator`

- **The class name of the authenticator to create**
  
  - `AppAuthenticator`

- **Generate a controller for the login page?**
  
  - `yes`

- **Controller name**
  
  - `SecurityController` (ou le défaut)

- **Generate a logout URL?**
  
  - `yes`

### Résultat attendu (fichiers générés)

On obtient en général :

- `src/Security/AppAuthenticator.php` (le coeur de l’auth)

- `src/Controller/SecurityController.php` (route `/login`)

- `templates/security/login.html.twig` (la vue)

---

## 3) Comprendre ce que Symfony vient de mettre en place

### 3.1 Le principe

- L’utilisateur arrive sur `/login`

- Il saisit email + mot de passe

- Symfony:
  
  - cherche l’utilisateur via l’email
  
  - vérifie le hash du mot de passe
  
  - connecte l’utilisateur et met son identité en session

### 3.2 Le “CSRF token”

Dans le formulaire, on voit un champ caché CSRF.

Pourquoi ?

- éviter qu’un site externe déclenche un login “à ton insu”

- c’est une protection standard

---

## 4) Vérifier et ajuster `security.yaml`

Fichier: `config/packages/security.yaml`

On doit retrouver des éléments proches de ça (les noms peuvent varier) :

- un **provider** basé sur l’entité `User`

- un **firewall** `main` qui utilise l’authenticator

- un **logout** branché sur `app_logout`

- des règles `access_control`

### Exemple de configuration typique (repère)

```yaml
security:
  password_hashers:
    App\Entity\User: 'auto'

  providers:
    app_user_provider:
      entity:
        class: App\Entity\User
        property: email

  firewalls:
    dev:
      pattern: ^/(_(profiler|wdt)|css|images|js)/
      security: false

    main:
      lazy: true
      provider: app_user_provider
      custom_authenticator: App\Security\AppAuthenticator
      logout:
        path: app_logout

  access_control:
    - { path: ^/login, roles: PUBLIC_ACCESS }
    - { path: ^/logout, roles: PUBLIC_ACCESS }
    - { path: ^/admin(?:/|$), roles: ROLE_ADMIN }
```

### Explication simple

- `providers`: dit à Symfony comment récupérer un `User` (ici via Doctrine et `email`)

- `firewalls.main`: active l’authentification sur le site

- `custom_authenticator`: branche la logique générée par `make:auth`

- `logout`: active la route de déconnexion

- `access_control`: protège des URLs

> Note: selon la version/config, Symfony peut utiliser `PUBLIC_ACCESS` pour les pages publiques.

---

## 5) Vérifier les routes (login / logout)

### Commandes

```bash
php bin/console debug:router | grep -i login
php bin/console debug:router | grep -i logout
```

Résultat attendu (exemples) :

- `app_login` -> `/login`

- `app_logout` -> `/logout`

---

## 6) Personnaliser la page `login.html.twig`

Fichier: `templates/security/login.html.twig`

### Objectif minimal

- afficher un titre

- afficher une erreur si login invalide

- afficher un formulaire email + password

- afficher un bouton “Se connecter”

- éventuellement afficher “Connecté en tant que …” + lien logout

### Exemple simple (structure classique)

```twig
{% extends 'base.html.twig' %}

{% block title %}Connexion{% endblock %}

{% block body %}
  <h1>Connexion</h1>

  {% if error %}
    <div style="padding: 10px; border: 1px solid #c00;">
      {{ error.messageKey|trans(error.messageData, 'security') }}
    </div>
  {% endif %}

  {% if app.user %}
    <p>
      Connecté en tant que <strong>{{ app.user.userIdentifier }}</strong>
      - <a href="{{ path('app_logout') }}">Se déconnecter</a>
    </p>
  {% endif %}

  <form method="post">
    <div>
      <label for="inputEmail">Email</label><br>
      <input
        type="email"
        value="{{ last_username }}"
        name="email"
        id="inputEmail"
        autocomplete="email"
        required
        autofocus
      >
    </div>

    <div style="margin-top: 10px;">
      <label for="inputPassword">Mot de passe</label><br>
      <input
        type="password"
        name="password"
        id="inputPassword"
        autocomplete="current-password"
        required
      >
    </div>

    <input type="hidden" name="_csrf_token" value="{{ csrf_token('authenticate') }}">

    <div style="margin-top: 15px;">
      <button type="submit">Se connecter</button>
    </div>
  </form>
{% endblock %}
```

---

## 7) Tester en conditions réelles

### 7.1 Créer (ou vérifier) un utilisateur

Si besoin :

```bash
php bin/console app:create-user admin@site.test "admin123" "ROLE_ADMIN,ROLE_USER"
```

### 7.2 Démarrer le serveur

```bash
symfony serve
```

ou

```bash
php -S 127.0.0.1:8000 -t public
```

### 7.3 Scénario de test

1. Aller sur `http://127.0.0.1:8000/login`

2. Se connecter avec `admin@site.test` / `admin123`

3. Aller sur une URL protégée, ex: `http://127.0.0.1:8000/admin`

4. Vérifier :
   
   - si non connecté: redirection vers `/login`
   
   - si connecté avec `ROLE_ADMIN`: accès OK

---

## 8) Bonus utile: redirection après login

Dans `src/Security/AppAuthenticator.php`, une méthode décide où aller après connexion (souvent `onAuthenticationSuccess`).

### Objectif courant

- si on voulait accéder à `/admin`, Symfony renvoie vers `/admin`

- sinon on renvoie vers une page par défaut (ex: homepage)

On peut mettre une destination par défaut vers :

- une route `app_home`

- ou une route `admin_dashboard`

---

## 9) Récapitulatif

- `make:auth` génère l’authenticator, le controller et le template de login.

- `security.yaml` doit contenir :
  
  - un provider User (email)
  
  - un firewall `main` + `custom_authenticator`
  
  - `logout`
  
  - `access_control` (au moins `/login` en public et `/admin` protégé)

- `login.html.twig` est la page à personnaliser.

- test final: accès `/admin` -> redirection login -> connexion -> accès autorisé.
