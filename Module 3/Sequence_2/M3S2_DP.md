<img src="../../Logo.png" width="550" height="75" alt="logo">

# Déroulé pédagogique

## Module 3 - Séquence 2

## Architecture MVC - Framework PHP PDO vs Symfony 7.4 (6 jours)

---

## Objectif global de la séquence (6 jours)

Comprendre en profondeur les principes d’un framework MVC en PHP en :

* analysant un **framework PHP PDO minimaliste** généré par script shell,
* identifiant ses composants clés (Front Controller, routage, contrôleurs, modèles, vues),
* puis en **reproduisant et comparant ces mécanismes dans Symfony 7.4**.

À l’issue de la séquence, les stagiaires doivent dire non seulement *comment utiliser Symfony*, mais surtout **pourquoi il fonctionne ainsi**.

---

## Jour 1 - Découverte et analyse du framework PHP PDO (framework “maison”)

### Contenus jour 1

* Rappel des limites du PHP procédural (couplage, duplication, maintenance)
* Présentation du framework PHP PDO généré par `script.sh`
* Lecture guidée de l’arborescence du projet :

  * `public/`
  * `app/Controller`
  * `app/Model`
  * `app/View`
  * `config/`
* Rôle du **Front Controller**
* Cycle de vie d’une requête HTTP dans le projet

---

### Activités pédagogiques jour 1

* Exécution du script `restaurant.sh`
* Prise en main du projet généré
* Analyse collective de l’arborescence
* Lecture commentée du `index.php` (Front Controller)
* Schéma du cheminement d’une requête (navigateur → contrôleur → vue)
* Repérage des responsabilités de chaque dossier

---

### Objectif du jour 1

Être capable d’expliquer l’architecture globale du framework PHP PDO et le rôle central du Front Controller.

---

## Jour 2 - MVC opérationnel : contrôleurs, modèles et vues (framework PDO)

### Contenus jour 2

* Contrôleurs orientés objet :

  * actions = méthodes
  * récupération des paramètres
* Accès aux données via PDO :

  * classe de connexion
  * repositories / modèles
* Organisation des vues :

  * templates PHP
  * transmission de données
* Séparation logique métier / affichage

---

### Activités pédagogiques jour 2

* Étude détaillée d’un contrôleur existant
* Analyse d’un modèle PDO (requêtes préparées)
* Ajout ou modification d’une action (liste, ajout, suppression)
* Modification d’une vue sans toucher au contrôleur
* Mise en évidence de la séparation des responsabilités

---

### Objectif du jour 2

Comprendre concrètement comment MVC s’exprime dans un framework PHP simple et maîtriser les échanges entre contrôleur, modèle et vue.

---

## Jour 3 - Approfondissement, limites et préparation à Symfony

### Contenus jour 3

* Gestion du routage “manuel”
* Centralisation de la configuration
* Gestion des erreurs et affichage
* Limites du framework maison :

  * sécurité
  * évolutivité
  * duplication
* Mise en perspective : pourquoi les frameworks existent

---

### Activités pédagogiques jour 3

* Ajout d’une nouvelle route manuellement
* Ajout d’un nouveau contrôleur
* Discussion collective sur les limites rencontrées
* Tableau comparatif “framework maison vs framework industriel”
* Introduction conceptuelle à Symfony :

  * composants
  * conventions
  * écosystème

---

### Objectif du jour 3

Identifier clairement les forces et faiblesses d’un framework PHP fait maison et comprendre le besoin d’un framework comme Symfony.

---

## Jour 4 - Découverte de Symfony 7.4 et mise en place du socle

### Contenus jour 4

* Présentation de Symfony 7.4
* Architecture standard Symfony :

  * `src/Controller`
  * `templates/`
  * `config/`
  * `public/`
* Rôle du kernel et du Front Controller Symfony
* Routage par attributs
* Premier contrôleur Symfony

---

### Activités pédagogiques jour 4

* Création d’un projet Symfony 7.4
* Démarrage du serveur de développement
* Création d’un contrôleur simple
* Analyse du Front Controller Symfony (`public/index.php`)
* Comparaison directe avec le Front Controller du framework PDO

---

### Objectif du jour 4

Comprendre l’architecture de base de Symfony et faire le lien avec les concepts déjà étudiés dans le framework PHP PDO.

---

## Jour 5 - Modèles, base de données et vues avec Symfony

### Contenus jour 5

* Doctrine ORM :

  * entités
  * repositories
* Différences PDO / ORM
* Twig :

  * séparation stricte vue / logique
  * héritage de templates
* Transmission de données contrôleur → vue

---

### Activités pédagogiques  jour 5

* Création d’une entité équivalente au projet PDO
* Mise en place de la base de données
* Création d’un repository
* Création de vues Twig
* Réalisation d’une fonctionnalité identique au projet PDO (liste ou détail)

---

### Objectif du jour 5

Savoir reproduire fonctionnellement une partie du projet PDO dans Symfony en comprenant les abstractions supplémentaires apportées par Doctrine et Twig.

---

## Jour 6 - Comparaison finale et synthèse architecturale

### Contenus jour 6

* Comparaison détaillée :

  * routage
  * contrôleurs
  * modèles
  * vues
  * configuration
* Avantages et inconvénients des deux approches
* Lisibilité, maintenabilité, évolutivité
* Bonnes pratiques professionnelles

---

### Activités pédagogiques jour 6

* Tableau comparatif complet “Framework PDO vs Symfony”
* Relecture collective des deux projets
* Questions / réponses techniques
* Mise en situation professionnelle :

  * “Quand faire un framework maison ?”
  * “Quand utiliser Symfony ?”
* Synthèse écrite ou orale par les stagiaires

---

### Objectif du jour 6

Être capable d’expliquer Symfony non comme une boîte noire, mais comme l’aboutissement logique des principes MVC étudiés précédemment.

---

## Synthèse de la séquence

Cette séquence de 6 jours permet une **montée en compétence progressive et raisonnée** :

* comprendre MVC **avant** d’utiliser Symfony,
* démystifier le framework,
* donner aux stagiaires une vision claire et professionnelle de l’architecture web moderne en PHP.
