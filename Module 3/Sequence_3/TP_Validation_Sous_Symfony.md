<img src="../../Logo.png" width="550" height="75" alt="logo">

# TP – Validation des données avec Symfony

## Entité Client

---

## Objectif

L’objectif de ce TP est de mettre en place des **règles de validation des données** sur une entité `Client`, puis de vérifier que les **formulaires Symfony** refusent les saisies invalides et affichent des messages d’erreur clairs à l’utilisateur.

À la fin du TP, l’application devra:

* refuser les champs obligatoires vides,
* refuser les formats incorrects (email invalide),
* afficher les erreurs directement dans le formulaire,
* accepter uniquement des données cohérentes.

---

## Contexte

L’application possède une entité `Client` avec les champs suivants:

* `name` (nom du client)
* `email` (adresse email)

Un formulaire Symfony permet de créer et modifier des clients via un CRUD.

---

## 1 - Installation du composant Validator

Symfony utilise un composant dédié pour la validation des données.

Dans le projet, installer le Validator (si ce n’est pas déjà fait):

```bash
composer require symfony/validator
```

---

## 2 - Principe de la validation dans Symfony

La validation repose sur des **contraintes**:

* une contrainte est une règle appliquée à une propriété,
* elle vérifie que la donnée respecte une condition (non vide, longueur, format, etc.),
* les contraintes sont généralement placées directement dans l’entité.

Symfony valide automatiquement les données d’un formulaire avant leur enregistrement.

---

## 3 - Ajout des contraintes dans l’entité Client

### Étape 1: Importer les contraintes

Dans le fichier `src/Entity/Client.php`, importer le namespace des contraintes:

```php
use Symfony\Component\Validator\Constraints as Assert;
```

---

### Étape 2: Ajouter les contraintes sur les propriétés

Ajouter des contraintes sur les champs `name` et `email`.

Exemple:

```php
#[ORM\Column(length: 100)]
#[Assert\NotBlank(message: "Le nom est obligatoire.")]
#[Assert\Length(
    min: 2,
    max: 100,
    minMessage: "Le nom doit contenir au moins {{ limit }} caractères.",
    maxMessage: "Le nom ne doit pas dépasser {{ limit }} caractères."
)]
#[Assert\Regex(message: "Le nom doit être une chaîne de caractères.",
    pattern: '/^[a-z]+$/i',
    htmlPattern: '^[a-zA-Z]+$'
)]
private ?string $name = null;
```

```php
#[ORM\Column(length: 100)]
#[Assert\NotBlank(message: "L'email est obligatoire.")]
#[Assert\Email(message: "L'adresse email '{{ value }}' n'est pas valide.")]
#[Assert\Length(
    max: 100,
    maxMessage: "L'email ne doit pas dépasser {{ limit }} caractères."
)]
private ?string $email = null;
```

---

## 4 - Formulaire ClientType

Le formulaire Symfony utilise automatiquement les contraintes définies dans l’entité.

Le formulaire `ClientType` peut rester simple, mais il est conseillé de:

* typer les champs,
* définir des labels lisibles,
* ajouter des attributs HTML utiles (placeholder, maxlength).

Dans le fichier `src/Form/ClientType.php`, importer le namespace des contraintes:

```php
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
```

Puis vous pouvez modifier `$builder`:

```php
$builder
    ->add('name', TextType::class, [
        'label' => 'Nom',
        'attr' => [
            'maxlength' => 100,
            'placeholder' => 'Ex: Marie Dupont',
        ],
    ])
    ->add('email', EmailType::class, [
        'label' => 'Email',
        'attr' => [
            'maxlength' => 100,
            'placeholder' => 'ex: marie@domaine.fr',
        ],
    ]);
```

Aucune validation supplémentaire n’est nécessaire dans le formulaire.

---

## 5 - Affichage des erreurs dans les templates Twig

### Rendu simple

Dans le template `templates/client/_form.html.twig`:

```twig
{{ form_start(form) }}
{{ form_widget(form) }}
<button class="btn">{{ button_label|default('Save') }}</button>
{{ form_end(form) }}
```

Symfony affiche automatiquement les erreurs.

---

### Rendu détaillé (recommandé pédagogiquement)

```twig
{{ form_start(form) }}

{{ form_errors(form) }}

<div>
    {{ form_label(form.name) }}
    {{ form_widget(form.name) }}
    {{ form_errors(form.name) }}
</div>

<div>
    {{ form_label(form.email) }}
    {{ form_widget(form.email) }}
    {{ form_errors(form.email) }}
</div>

<button class="btn">{{ button_label|default('Save') }}</button>

{{ form_end(form) }}
```

---

## 6 - Tests à réaliser

Tester les cas suivants depuis le formulaire:

### Champ `name`

* champ vide -> refusé
* 1 seul caractère -> refusé
* 2 caractères ou plus -> accepté

### Champ `email`

* champ vide -> refusé
* email invalide (`abc`, `a@`, `@test.fr`) -> refusé
* email valide -> accepté

---

## 7 - Validation lors de la modification

* ouvrir un client existant,
* saisir des valeurs invalides -> refus,
* saisir des valeurs valides -> enregistrement autorisé.

---

## 8 - (Option) Empêcher les doublons d’email

Pour interdire plusieurs clients avec le même email, il est possible d’ajouter une contrainte d’unicité côté validation.

Exemple:

```php
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;

#[UniqueEntity(
    fields: ['email'],
    message: "Cet email est déjà utilisé."
)]
```

Cette règle empêche l’enregistrement avant même l’accès à la base de données.
