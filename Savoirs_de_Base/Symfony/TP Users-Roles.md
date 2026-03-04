# TP Live coding - Users + rôles dans Symfony 7.4

## Objectif

Obtenir :

* une entité `User` compatible avec le système de sécurité Symfony
* une gestion des rôles (ex : `ROLE_USER`, `ROLE_ADMIN`)
* un point de départ solide pour ajouter ensuite un login
* un stockage correct du mot de passe (hash, jamais en clair)
* une méthode simple pour créer rapidement un compte administrateur
* une première règle de protection d’URL via `security.yaml`

---

## Pré-requis

On part du principe que :

* un projet Symfony 7.4 existe déjà
* la base de données est configurée et Doctrine fonctionne (connexion OK, migrations possibles)
* les commandes Symfony sont disponibles via `php bin/console`
* l’application peut être lancée avec `symfony serve`, `php -S 127.0.0.1:8000 -t /public` ou un serveur Apache/Nginx

### Explication

Symfony organise l’application autour de plusieurs briques :

* **Doctrine** s’occupe de la base de données (tables, requêtes, entités).
* **Security** s’occupe des utilisateurs, des rôles, et de l’authentification.
* Les commandes `php bin/console` servent à générer du code et à automatiser des actions (migrations, génération d’entités, etc.).

---

## 1) Installer le nécessaire pour la sécurité

### Commande

```bash
composer require symfony/security-bundle
```

### Explication (simple)

On installe le composant de sécurité de Symfony.
Ce composant fournit les mécanismes fondamentaux :

* savoir “qui est l’utilisateur connecté”
* gérer des **rôles** (autorisation)
* préparer l’authentification (login, logout, etc.)

À ce stade, on ne met pas encore en place un formulaire de login. C'est l'étape suivante.

---

## 2) Générer l’entité `User` (approche simple et standard)

### 2.1 Commande

```bash
php bin/console make:user
```

### 2.2 Choix conseillés pendant l’assistant

* **User class name** : `User`
  On choisit un nom simple et classique.

* **Store user in database** : `yes`
  Cela signifie que les utilisateurs seront stockés en base, dans une table.

* **Unique identifier** : `email`
  Cela signifie que l’email servira d’identifiant de connexion (au lieu d’un pseudo).

* **Do you want to hash passwords** : `yes`
  Symfony va prévoir un système de hash sécurisé pour les mots de passe.

* **Password field name** : `password`
  C’est le nom habituel pour stocker le hash du mot de passe.

### 2.3 Explication (simple)

Cette commande génère une entité `User` conforme aux besoins de Symfony :

* **un identifiant unique** : ici `email`
  Donc deux utilisateurs ne peuvent pas partager le même email.

* **un champ `password`** : il contient un **hash**
  Un hash est une version “transformée” du mot de passe :
  
  * on ne peut pas retrouver le mot de passe original à partir du hash
  * c’est indispensable pour la sécurité

* **un tableau `roles`** : il contient des rôles comme `ROLE_USER`, `ROLE_ADMIN`
  Les rôles servent à dire : “cet utilisateur a le droit de faire telle ou telle chose”.

---

## 3) Vérifier le contenu de l’entité `User`

Dans `src/Entity/User.php`, on retrouve généralement :

* `email` : champ unique

* `roles` : tableau de rôles

* `password` : chaîne de caractères contenant le hash

* des méthodes importantes :
  
  * `getUserIdentifier()` : renvoie l’identifiant unique (souvent l’email)
  * `getRoles()` : renvoie les rôles de l’utilisateur

### Point important

Symfony attend que `getRoles()` renvoie **toujours au moins** `ROLE_USER`, même si le tableau en base est vide.

Pourquoi ?

* Symfony considère qu’un utilisateur “normal” doit au minimum avoir un rôle standard.
* Cela évite des situations où un utilisateur serait connecté mais n’aurait “aucun rôle” et se comporterait de manière imprévisible.

En pratique, on voit souvent dans `getRoles()` une logique du style :

* on lit `$this->roles`
* on ajoute `ROLE_USER` si besoin
* on renvoie le tableau final

---

## 4) Migrer la base de données

### Commandes

```bash
php bin/console make:migration
php bin/console doctrine:migrations:migrate
```

### Explication (simple)

* `make:migration` génère un fichier qui décrit ce qu’il faut changer en base (SQL généré par Doctrine)
* `migrate` applique réellement ces changements

Résultat attendu :

* une table `user` (ou `users` selon la config) est créée
* avec les colonnes : `id`, `email`, `roles`, `password`, etc.

---

## 5) Créer un administrateur rapidement (méthode propre)

L’idée consiste à créer une commande Symfony qui insère un utilisateur en base, tout en hashant le mot de passe correctement.

Pourquoi c’est utile ?

* au début d’un projet, il n’y a pas encore d’interface pour gérer les comptes
* on a souvent besoin d’un premier compte admin pour démarrer

### 5.1 Créer une commande

```bash
php bin/console make:command app:create-user
```

Nom de classe proposé : `CreateUserCommand`

### 5.2 Implémenter la commande

Créer ou éditer : `src/Command/CreateUserCommand.php`

```php
<?php

namespace App\Command;

use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

#[AsCommand(
    name: 'app:create-user',
    description: 'Crée un utilisateur avec un mot de passe hashé et des rôles.',
)]
class CreateUserCommand extends Command
{
    public function __construct(
        private readonly EntityManagerInterface $em,
        private readonly UserPasswordHasherInterface $passwordHasher,
    ) {
        parent::__construct();
    }

    protected function configure(): void
    {
        $this
            ->addArgument('email', InputArgument::REQUIRED, 'Email de l’utilisateur')
            ->addArgument('password', InputArgument::REQUIRED, 'Mot de passe en clair (sera hashé)')
            ->addArgument('roles', InputArgument::OPTIONAL, 'Rôles séparés par des virgules (ex: ROLE_ADMIN,ROLE_USER)', 'ROLE_USER')
            ;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {

        $email = (string) $input->getArgument('email');
        $plainPassword = (string) $input->getArgument('password');
        $roleString = (string) $input->getArgument('roles');

        // On découpe la chaîne "ROLE_ADMIN,ROLE_USER" en tableau ["ROLE_ADMIN", "ROLE_USER"]
        $roles = array_map('trim', explode(',', $roleString));
        $roles = array_values(array_filter($roles));

        $user = new User();
        $user->setEmail($email);
        $user->setRoles($roles);

        // Le mot de passe est hashé avant l’enregistrement.
        $hashedPassword = $this->passwordHasher->hashPassword($user, $plainPassword);
        $user->setPassword($hashedPassword);

        // persist = Doctrine prépare l’insertion
        // flush = Doctrine exécute réellement l’insertion en base
        $this->em->persist($user);
        $this->em->flush();

        $output->writeln('Utilisateur créé : '.$email);
        //$output->writeln('Voici le mot de passe : '.$plainPassword);
        //$output->writeln('Voici le hash : '.$hashedPassword);
        $output->writeln('Rôles : '.implode(', ', $roles));

        return Command::SUCCESS;
    }
}
```

### Explications simples sur ce qui se passe

* `EntityManagerInterface` sert à parler à Doctrine : enregistrer des objets en base.
* `UserPasswordHasherInterface` sert à hasher le mot de passe avec la stratégie recommandée par Symfony.
* `persist()` dit : “Doctrine doit enregistrer cet objet”.
* `flush()` dit : “Doctrine exécute maintenant les requêtes SQL”.

### 5.3 Tester la commande

```bash
php bin/console app:create-user admin@site.test "admin123" "ROLE_ADMIN,ROLE_USER"
```

---

## 6) Ajouter une règle simple de contrôle d’accès

### 6.1 Comprendre le rôle de `security.yaml`

Le fichier `config/packages/security.yaml` est un fichier de configuration Symfony.
Il sert à décrire :

* comment Symfony trouve les utilisateurs (provider)
* comment l’authentification fonctionne (firewall)
* quelles pages sont protégées (access_control)
* comment les rôles sont interprétés

Dans ce TP, on commence simplement par une règle d’accès.

### 6.2 Ajouter la règle

Dans `config/packages/security.yaml`, on peut ajouter :

```yaml
security:
  access_control:
    - { path: ^/admin(?:/|$), roles: ROLE_ADMIN }
```

### Explication

Cette règle signifie :

* si l’URL commence par `/admin`
* alors il faut avoir le rôle `ROLE_ADMIN`

Cela permet de protéger un espace d’administration, même avant d’avoir un login complet.

---

## 7) Règles essentielles de YAML (important pour éviter les erreurs)

YAML est un format de configuration basé sur l’indentation.
Dans Symfony, de nombreux fichiers de config utilisent YAML.

### 7.1 Indentation

* l’indentation est obligatoire
* on utilise en général **2 espaces**
* il ne faut pas mélanger tabulations et espaces

Exemple :

```yaml
security:
  access_control:
    - { path: ^/admin(?:/|$), roles: ROLE_ADMIN }
```

Ici :

* `access_control` est “dans” `security` parce qu’il est plus indenté.

### 7.2 Les listes (avec des tirets)

Un tiret `-` indique un élément d’une liste.

```yaml
access_control:
  - { path: ^/admin(?:/|$), roles: ROLE_ADMIN }
  - { path: ^/manager(?:/|$), roles: ROLE_MANAGER }
```

Ici, `access_control` contient deux règles.

### 7.3 Les dictionnaires (clé: valeur)

La forme `clé: valeur` est un dictionnaire.

```yaml
security:
  enable_authenticator_manager: true
```

Ici, `enable_authenticator_manager` vaut `true`.

### 7.4 Les chaînes et les guillemets

On peut mettre des guillemets si la valeur contient des caractères particuliers, mais ce n’est pas toujours nécessaire.

Exemple :

```yaml
interval: '15 minutes'
```

Les guillemets évitent des interprétations ambiguës.

### 7.5 Erreurs fréquentes

* indentation incorrecte (erreur la plus fréquente)
* tabulations utilisées au lieu d’espaces
* oubli du tiret dans une liste
* mauvais alignement des niveaux

Quand YAML est incorrect, Symfony affiche souvent une erreur qui mentionne :

* le fichier (`security.yaml`)
* la ligne concernée
* et parfois une indication sur l’indentation

--

## 8) Récapitulatif

* Une entité `User` Symfony fournit un identifiant unique (souvent `email`) et un tableau de rôles.
* Un mot de passe ne se stocke jamais en clair : on stocke uniquement un hash.
* Les rôles suivent une convention (`ROLE_...`) et `ROLE_USER` doit être présent par défaut.
* Une commande Symfony permet de créer un utilisateur proprement sans interface.
* `security.yaml` permet de poser des règles simples de protection d’URL.
* YAML est sensible à l’indentation : les espaces et les listes doivent être strictement respectés.
