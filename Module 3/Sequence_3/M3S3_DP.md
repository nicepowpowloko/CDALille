<img src="../../Logo.png" width="550" height="75" alt="logo">

# Déroulé pédagogique

## Module 3 - Séquence 3

## Validation des données et fiabilisation des formulaires Symfony (1 jour)

---

## Objectif global de la séquence (1 jour)

Comprendre et mettre en oeuvre la **validation des données dans Symfony** afin de garantir la cohérence, la fiabilité et la qualité des informations saisies par l'utilisateur.

À l’issue de la journée, les stagiaires doivent être capables de :

* définir des règles de validation métier,
* comprendre le rôle du composant Validator,
* relier entité, formulaire et affichage Twig,
* expliquer pourquoi une validation côté serveur est indispensable.

---

## Journée unique - Validation des données avec Symfony

### Contenus abordés

* Rappels sur la problématique de la validation des données :

  * données utilisateur non fiables,
  * risques fonctionnels et applicatifs,
  * différence validation client / serveur.

* Présentation du composant **Validator** de Symfony :

  * principe des contraintes,
  * validation automatique des formulaires,
  * cycle de validation.

* Contraintes de validation courantes :

  * NotBlank,
  * Length,
  * Email,
  * Regex.

* Lien entre :

  * entité Doctrine,
  * formulaire Symfony,
  * affichage des erreurs dans Twig.

---

### Activités pédagogiques

* Création ou reprise de l’entité **Client** :

  * `name` (varchar 100),
  * `email` (varchar 100).

* Installation et activation du composant Validator.

* Ajout de contraintes de validation directement dans l’entité :

  * champs obligatoires,
  * longueurs minimales et maximales,
  * format de l’adresse email.

* Création / adaptation du formulaire **ClientType** :

  * typage des champs,
  * labels clairs,
  * attributs HTML utiles.

* Mise en place de l’affichage détaillé des erreurs dans les templates Twig.

* Tests fonctionnels :

  * saisies invalides,
  * messages d’erreur,
  * enregistrement de données valides.

---

### Mise en perspective professionnelle

* Importance de la validation côté serveur dans un contexte réel.
* Différence entre contraintes techniques et règles métier.
* Prévention des erreurs avant l’accès à la base de données.
* Introduction à la notion de qualité des données dans une application.

---

### Objectif pédagogique de la journée

Être capable de :

* sécuriser les entrées utilisateur,
* expliquer le rôle exact du Validator dans Symfony,
* mettre en place un formulaire fiable et cohérent,
* comprendre que la validation fait partie intégrante de l’architecture applicative.

---

### Synthèse

Cette séquence M3S3 constitue une étape clé entre :

* la découverte de Symfony,
* et la mise en oeuvre de bonnes pratiques professionnelles.

Elle prépare directement les stagiaires aux futures notions de :

* persistance sécurisée des données,
* logique métier avancée,
* robustesse applicative.

