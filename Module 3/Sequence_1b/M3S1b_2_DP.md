<img src="../../Logo.png" width="550" height="75" alt="logo">

# Déroulé pédagogique – Module 3 Séquence 2

## Architecture MVC en PHP – Du procédural à la POO (2 jours)

### Objectif global

Comprendre et mettre en œuvre une architecture **MVC (Model - View - Controller)** en PHP, en partant d’un code procédural existant et en le faisant évoluer progressivement vers une structure claire, lisible et maintenable, préparant l’introduction d’un framework comme Symfony.

---

## Jour 1 – Comprendre MVC et initier la transformation d’un projet existant

### Contenus

* Rappels sur les limites du PHP procédural dans un projet évolutif
* Présentation du modèle MVC:

  * Rôle du contrôleur
  * Rôle du modèle
  * Rôle de la vue
* Notion de Front Controller
* Circulation d’une requête HTTP dans une application MVC
* Séparation des responsabilités:

  * logique métier
  * accès aux données
  * rendu HTML
* Introduction aux contrôleurs orientés objet

---

### Activités pédagogiques

* Analyse collective d’un mini blog PHP procédural existant
* Identification des mélanges de responsabilités dans le code
* Étude de schémas expliquant les flux HTTP et MVC
* Mise en place de la structure de base du projet **MVC_EvoV2**
* Création du Front Controller (`public/index.php`)
* Premiers contrôleurs et routage simple
* Début de la refactorisation du TP vers une architecture MVC

---

### Objectif du jour

Être capable d’expliquer le fonctionnement global d’une application MVC et d’initier la transformation d’un projet PHP procédural vers une structure MVC simple.

---

## Jour 2 – Approfondissement MVC et finalisation du TP

### Contenus

* Contrôleurs orientés objet:

  * actions = méthodes
  * responsabilités du contrôleur
* Le modèle:

  * Repository
  * centralisation des accès PDO
* Introduction aux entités (ou structures de données simples)
* Les vues:

  * templates PHP
  * notion de layout
* Séparation logique métier / logique de présentation
* Bonnes pratiques MVC:

  * lisibilité
  * maintenabilité
  * évolutivité

---

### Activités pédagogiques

* Poursuite et finalisation du TP **MVC_EvoV2**
* Mise en place des repositories pour l’accès aux données
* Passage des traitements métier hors des contrôleurs
* Création et utilisation de vues dédiées
* Tests manuels des fonctionnalités (liste, création, suppression)
* Échanges collectifs sur les choix d’architecture réalisés
* Comparaison avec l’architecture Symfony

---

### Objectif du jour

Être capable de structurer un mini-projet PHP selon le modèle MVC, en identifiant clairement les rôles de chaque couche et en produisant un code plus lisible et maintenable.

---

## TP fil rouge – Mini blog MVC en PHP

Développement progressif d’un mini blog en PHP comprenant:

* Une entrée unique via un Front Controller
* Des contrôleurs orientés objet
* Un accès aux données centralisé via PDO (Repository)
* Des vues séparées du traitement métier
* Une architecture MVC cohérente et fonctionnelle

---

## Synthèse de la séquence

Cette séquence permet aux stagiaires de passer d’une logique PHP procédurale à une architecture MVC structurée, en comprenant les motivations et les bénéfices de cette organisation. Elle prépare efficacement l’introduction de Symfony en donnant des repères clairs sur le rôle des contrôleurs, des modèles, des vues et sur la circulation des requêtes dans une application web moderne.

