# TP Live coding - Sécuriser l’accès aux routes (access_control + conventions de routes)

*(On s’appuie sur le `security.yaml` actuel, encore en config “squelette” avec provider in-memory et `access_control` commenté.)*

## Objectif

À la fin du TP, on sait :

- protéger des **zones d’URL** via `security.yaml` (`access_control`)

- normer les routes avec une convention claire: **un préfixe d’URL = un rôle**

- tester les cas: non connecté, `ROLE_USER`, `ROLE_ADMIN`

- comprendre l’ordre des règles (la première qui matche gagne)

---

## Pré-requis

On part du principe que :

- l’entité `User` existe déjà + des utilisateurs en base (Chapitre 17)

- la page de login existe déjà (TP login)

- on peut lancer le projet et tester des URLs

---

## 1) Principe clé: “une zone = un préfixe”

On adopte une convention simple.

### Convention proposée (norme de routes)

- Routes publiques: `/` , `/about`, `/contact` (aucun rôle requis)

- Zone utilisateur connectée: `/app/...` -> `ROLE_USER`

- Zone admin: `/admin/...` -> `ROLE_ADMIN`

- (Optionnel) Zone manager: `/manager/...` -> `ROLE_MANAGER`

Pourquoi c’est utile :

- c’est lisible dans l’URL

- c’est facile à configurer dans `access_control`

- ça évite de multiplier des règles sans structure

---

## 2) Mettre `security.yaml` dans un état cohérent

Le fichier actuel est en mode “squelette” (provider in-memory, pas d’access_control actif).

### 2.1 Provider: utiliser l’entité User en base

Dans `config/packages/security.yaml`, on configure un provider Doctrine (via `email`), comme dans le Chapitre 17.

Exemple de bloc provider attendu (à adapter si besoin) :

```yaml
security:
  password_hashers:
    App\Entity\User: 'auto'

  providers:
    app_user_provider:
      entity:
        class: App\Entity\User
        property: email
```

> Si tout est déjà en place grâce au TP login, on ne touche pas.

### 2.2 Firewall “main” : brancher l’authenticator

Le firewall `main` doit utiliser le provider + l’authenticator généré par `make:auth` (le nom peut varier selon le projet). Le squelette actuel ne le fait pas encore.

Exemple typique :

```yaml
security:
  firewalls:
    main:
      lazy: true
      provider: app_user_provider
      custom_authenticator: App\Security\AppAuthenticator
      logout:
        path: app_logout
```

---

## 3) Ajouter les règles `access_control`

C’est ici que se joue la sécurité “par zones d’URL”.

### Point clé

**Une seule règle s’applique: la première qui matche.**  
Donc l’ordre est important.

### Règles proposées

```yaml
security:
  access_control:
    # Pages publiques
    - { path: ^/login, roles: PUBLIC_ACCESS }
    - { path: ^/logout, roles: PUBLIC_ACCESS }

    # Zone admin (à protéger fort)
    - { path: ^/admin(?:/|$), roles: ROLE_ADMIN }

    # Zone “app” pour utilisateurs connectés
    - { path: ^/app(?:/|$), roles: ROLE_USER }

    # Tout le reste: public (optionnel)
    # - { path: ^/, roles: PUBLIC_ACCESS }
```

### Explication simple

- `/admin` est réservé aux admins

- `/app` est réservé à tout utilisateur connecté (`ROLE_USER`)

- `/login` reste accessible à tout le monde

- `/logout` est géré par le firewall, mais laisser la route en `PUBLIC_ACCESS` peut éviter des surprises selon la config

---

## 4) Normer les routes côté code: préfixes + noms

L’idée: ranger les fonctionnalités au bon endroit.

### 4.1 Exemple: un contrôleur “app”

Créer `src/Controller/App/HomeController.php` :

```php
<?php

namespace App\Controller\App;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class HomeController extends AbstractController
{
    #[Route('/app', name: 'app_home')]
    public function index(): Response
    {
        return new Response('Zone /app: utilisateur connecté');
    }
}
```

### 4.2 Exemple: un contrôleur “admin”

Créer `src/Controller/Admin/DashboardController.php` :

```php
<?php

namespace App\Controller\Admin;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class DashboardController extends AbstractController
{
    #[Route('/admin', name: 'admin_dashboard')]
    public function index(): Response
    {
        return new Response('Zone /admin: admin seulement');
    }
}
```

### Convention de nommage des routes (recommandée)

- `app_*` pour `/app/...`

- `admin_*` pour `/admin/...`

- `public_*` pour le reste

Ça sert à :

- se repérer dans `debug:router`

- retrouver vite une route dans Twig (`path('admin_dashboard')`)

---

## 5) Tester: 3 scénarios obligatoires

### 5.1 Voir les routes

```bash
php bin/console debug:router | grep -E "app_|admin_"
```

### 5.2 Cas 1: non connecté

- `/app` -> redirection vers `/login`

- `/admin` -> redirection vers `/login`

### 5.3 Cas 2: connecté `ROLE_USER` (pas admin)

- `/app` -> OK

- `/admin` -> refus (403) en général

### 5.4 Cas 3: connecté `ROLE_ADMIN`

- `/admin` -> OK

- `/app` -> OK si `ROLE_USER` est aussi présent, ou si la hiérarchie est configurée (voir ci-dessous)

---

## 5.5 Point important: `ROLE_ADMIN` n’implique pas forcément `ROLE_USER`

Deux solutions possibles, au choix.

### Option A (simple)

On donne aussi `ROLE_USER` aux admins au moment de créer le compte:

```bash
php bin/console app:create-user admin@site.test "admin123" "ROLE_ADMIN,ROLE_USER"
```

### Option B (formalisée): hiérarchie des rôles

Dans `security.yaml`, ajouter:

```yaml
security:
  role_hierarchy:
    ROLE_ADMIN: ROLE_USER
```

Avec ça, un admin est automatiquement considéré comme user pour les contrôles d’accès.

---

## 6) Variante: sécuriser au niveau contrôleur (en complément)

`access_control` protège des zones entières.  
Pour une action précise, on peut ajouter une contrainte directement dans le contrôleur.

### Exemple avec attribut

```php
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Routing\Attribute\Route;

#[IsGranted('ROLE_ADMIN')]
#[Route('/admin/users', name: 'admin_users')]
public function users(): Response
{
    // ...
}
```

### Règle pratique

- `access_control`: pour les grandes zones (`/admin`, `/app`)

- `IsGranted` / `denyAccessUnlessGranted`: pour un point précis (ex: une action “supprimer”)

---

## 7) Exercices

### Exercice A

- Créer `/app/profile` -> accessible à `ROLE_USER`

- Créer `/admin/reports` -> accessible à `ROLE_ADMIN`

- Vérifier les accès avec 2 comptes (user et admin)

### Exercice B

- Ajouter une page publique `/about`

- Vérifier qu’elle est accessible sans être connecté

- Bonus: afficher dans la page “connecté: oui/non” via `app.user` en Twig

### Exercice C (piège classique)

- Ajouter en dernier: `- { path: ^/, roles: ROLE_USER }`

- Observer: ça force quasiment tout le site à être connecté

- Comprendre pourquoi l’ordre des règles est critique

---

## 8) Récapitulatif

- On norme: **un préfixe d’URL = un rôle**.

- `access_control` protège des zones, et **la première règle qui matche gagne**.

- On évite les regex trop larges en utilisant:
  
  - `^/admin(?:/|$)`
  
  - `^/app(?:/|$)`

- Conventions recommandées:
  
  - `/app/...` -> `app_*` -> `ROLE_USER`
  
  - `/admin/...` -> `admin_*` -> `ROLE_ADMIN`

- Si on veut que l’admin accède aussi à `/app`, on choisit:
  
  - soit `ROLE_ADMIN,ROLE_USER`
  
  - soit `role_hierarchy` dans `security.yaml`
