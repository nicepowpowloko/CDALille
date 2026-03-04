# Création d’un compte utilisateur et notions de sécurité (Symfony 7.4)

Ce document décrit la mise en place d’un formulaire de création de compte utilisateur, ainsi qu’un panorama des principales mesures de sécurité fournies par Symfony.
L’objectif est double :

* comprendre le **flux d’inscription**
* comprendre les **mécanismes de sécurité transverses** du framework

---

## Partie 1 – Création d’un compte utilisateur

---

## 1. Objectif fonctionnel

À la fin de cette partie, on dispose :

* d’un **formulaire de création de compte**
* d’un utilisateur enregistré en base
* d’un mot de passe **hashé**
* d’un compte utilisable immédiatement avec le système de login existant
* d’une base saine pour ajouter plus tard validation email, rôles avancés, etc.

---

## 2. Pré-requis

On part du principe que :

* l’entité `User` existe déjà
* elle implémente `UserInterface`
* les champs suivants sont présents :

  * `email`
  * `password`
  * `roles`
* l’authentification par formulaire fonctionne déjà

---

## 3. Création du formulaire d’inscription

### 3.1 Principe général

Un formulaire de création de compte doit :

* collecter les informations nécessaires
* valider les données
* **ne jamais stocker un mot de passe en clair**
* créer un utilisateur persistant en base

Symfony fournit des outils dédiés pour chacune de ces étapes.

---

## 4. Création du formulaire Symfony

### 4.1 Form Type

On crée un formulaire dédié, par exemple :

```
src/Form/RegistrationFormType.php
```

Principe :

* le champ `password` du formulaire n’est pas directement mappé à l’entité
* le hash est calculé côté contrôleur

Ce découplage est volontaire et essentiel pour la sécurité.

---

## 5. Contrôleur d’inscription

### 5.1 Responsabilités du contrôleur

Le contrôleur doit :

* instancier un nouvel objet `User`
* traiter le formulaire
* hasher le mot de passe
* enregistrer l’utilisateur en base
* éventuellement connecter l’utilisateur automatiquement

---

### 5.2 Hash du mot de passe

Symfony ne compare **jamais** des mots de passe en clair.

Le hash est réalisé via le service `UserPasswordHasherInterface`.

Principe :

* le mot de passe saisi est transformé
* seul le hash est stocké
* la comparaison est faite via le hasher, jamais manuellement

Cela garantit :

* l’irréversibilité du mot de passe
* la sécurité en cas de fuite de base de données

---

## 6. Validation des données

Lors de l’inscription, plusieurs validations sont essentielles :

* email valide
* unicité de l’email
* mot de passe non vide
* longueur minimale du mot de passe

Ces règles sont généralement portées par :

* les contraintes Symfony Validator
* la base de données (index unique)

La validation côté serveur est **obligatoire**, même si une validation frontend existe.

---

## 7. Sécurité minimale de l’inscription

Un formulaire d’inscription doit obligatoirement inclure :

* protection CSRF
* validation stricte des champs
* hashage du mot de passe
* limitation des rôles attribués (jamais ROLE_ADMIN)

Un utilisateur créé via un formulaire public doit recevoir :

```
ROLE_USER
```

et uniquement ce rôle.

---

## Partie 2 – Panorama des principales mesures de sécurité Symfony

---

## 8. Protection CSRF

### 8.1 Principe

Le CSRF (Cross-Site Request Forgery) consiste à forcer un utilisateur connecté à effectuer une action à son insu.

Symfony protège automatiquement :

* les formulaires Symfony
* les formulaires de login
* les actions sensibles

Via :

* un token unique
* stocké en session
* vérifié à la soumission

Sans CSRF valide, la requête est rejetée.

---

## 9. Hashage des mots de passe

Symfony ne stocke jamais de mot de passe en clair.

Le hashage :

* est configuré dans `security.yaml`
* utilise des algorithmes modernes (bcrypt, argon2)
* s’adapte automatiquement aux recommandations de sécurité

Le mot de passe :

* n’est jamais lisible
* n’est jamais récupérable

---

## 10. Authentification

Symfony gère :

* l’identification de l’utilisateur
* la création de la session
* la persistance de l’identité entre les requêtes

L’utilisateur authentifié est disponible :

* dans le contrôleur
* dans Twig
* dans les services

L’authentification est distincte de l’autorisation.

---

## 11. Autorisation et rôles

Les rôles permettent de déterminer **ce qu’un utilisateur a le droit de faire**.

Symfony fournit :

* `access_control` (sécurité par URL)
* `IsGranted` (sécurité par méthode)
* `denyAccessUnlessGranted`

Un utilisateur peut être :

* authentifié
* mais non autorisé

Dans ce cas, une erreur 403 est levée.

---

## 12. Séparation 401 / 403

Distinction fondamentale :

* 401 : utilisateur non authentifié
* 403 : utilisateur authentifié mais non autorisé

Symfony applique cette distinction automatiquement selon le contexte.

---

## 13. Protection des routes

Les routes sensibles doivent être protégées :

* soit via `access_control`
* soit via des attributs PHP

Il ne faut jamais se reposer uniquement sur l’interface utilisateur pour la sécurité.

---

## 14. Validation des entrées utilisateur

Symfony protège contre :

* injections SQL (via Doctrine)
* injections XSS (via Twig)
* données non conformes (Validator)

Twig échappe automatiquement les variables affichées, sauf indication contraire.

---

## 15. Gestion des erreurs de sécurité

En production :

* aucune information technique n’est affichée
* les erreurs sont journalisées
* les pages d’erreur sont contrôlées

Les erreurs de sécurité (403) doivent être traitées explicitement pour éviter toute fuite d’information.

---

## 16. Journalisation et traçabilité

Symfony permet :

* de tracer les erreurs
* de suivre les tentatives échouées
* d’analyser les incidents

Les logs sont un élément central de la sécurité opérationnelle.

---

## 17. Récapitulatif sécurité

Les piliers de la sécurité Symfony sont :

* authentification
* autorisation
* hashage des mots de passe
* protection CSRF
* validation des données
* gestion des erreurs
* logs

Aucun mécanisme isolé ne suffit.
C’est leur **combinaison** qui garantit un niveau de sécurité correct.

---

## Conclusion

La création de compte n’est pas une simple question de formulaire.
Elle s’inscrit dans un ensemble cohérent de mécanismes de sécurité fournis par Symfony.

Comprendre ces mécanismes permet :

* de développer des applications plus sûres
* de diagnostiquer plus facilement les erreurs
* d’éviter les fausses bonnes pratiques

Ce socle est indispensable avant toute montée en complexité (API, JWT, SSO, MFA).
