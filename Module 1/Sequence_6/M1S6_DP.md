<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Déroulé pédagogique  M1 S6**

## Code propre & qualité de développement

---

## **1 Comprendre les principes du Code Propre  45 min**

**Objectifs :**

- Identifier les mauvaises pratiques courantes et leurs conséquences (dette technique, bugs récurrents, code anxiogène).

- Comprendre les fondations du “Clean Code” : lisibilité, cohérence, simplicité, nommage clair.

- Découvrir des styles de code contrastés : rapide, ancien, moderne.

**Supports utilisés :**

- *Code_Propre.md*  sections “Pourquoi la qualité compte” et “Lisibilité du code”

- *TP_Clean_Code.md*  fiches “Fast / OldSchool / Modern” (pages 13)

**Activités :**

- Présentation guidée : qu’est-ce que la dette technique, comment elle se crée, comment elle se paie.

- Lecture comparée de trois styles de code issus du support :
  
  - **Fast.php** : rapide mais illisible, mélange de tout.
  
  - **OldSchool.php** : rigoureux mais daté.
  
  - **Modern.php** : lisible, structuré, sécurisé.

- Discussion : “Qu’est-ce qui rend le dernier style agréable à lire ?”.

**Livrable court :**

- 3 règles qu’un stagiaire s’engage à respecter immédiatement (nommage, indentation, fonctions courtes).

---

## **2 Conventions, organisation & structure des fichiers  1 h 15**

Basé sur : *Code_Propre.md*, sections conventions & organisation  

**Objectifs :**

- Comprendre les conventions modernes (PSR-1/PSR-12, conventions JS/HTML).

- Savoir structurer un projet (dossiers, fichiers, hiérarchie logique).

- Apprendre à éviter duplication, code mort, mélange des responsabilités.

**Contenu abordé :**

- Importance des noms explicites, fonctions courtes, niveaux d’imbrication faibles.

- Organisation d’un projet : séparation HTML / CSS / JS, dossiers cohérents.

- Pourquoi supprimer le code mort (l’historique est dans Git).

**Activités :**

- Étude d’un petit projet fourni : repérage des redondances et des “smells”.

- Réécriture guidée d’un fichier mal structuré.

**Livrables :**

- Version restructurée du fichier fourni en exercice (noms + indentation + logique clarifiée).

---

## **3 Outils modernes : linters, formatteurs & analyseurs  1 h 30**

Basé sur : *Code_Propre.md*  section outillage qualité  

**Objectifs :**

- Découvrir les outils automatiques qui garantissent une qualité de code régulière.

- Comprendre la différence entre linter, formatteur et analyseur statique.

- Configurer ses outils dans VS Code pour automatiser la qualité.

**Contenu abordé :**

- Linters : ESLint (JS), stylelint (CSS), PHP_CodeSniffer (PHP).

- Formateurs : Prettier, PHP-CS-Fixer.

- Analyse statique : PHPStan, Psalm.

- Validation HTML/CSS (W3C Validator, DevTools).

**Activités :**

- Installation d’ESLint et Prettier dans un mini-projet d’exemple.

- Démonstration : un fichier “moche” → auto-format → version lisible.

- Test d’un validateur HTML/CSS sur une page imparfaite.

**Livrables :**

- Projet propre avec linter + formatteur fonctionnels.

- Rapport court : “Ce que l’outil a corrigé automatiquement”.

---

## **4 Intégrer la qualité dans un workflow moderne  1 h 30**

Basé sur : *Code_Propre.md* (intégration dans le flux de travail)  
et *RGPD&RGAA.md* (qualité → accessibilité → responsabilité)

**Objectifs :**

- Mettre en place des habitudes professionnelles (format-on-save, Git hooks).

- Comprendre que qualité technique + accessibilité = qualité globale du projet.

- Introduire les bonnes pratiques légales (HTML accessible, RGPD minimal).

**Contenu abordé :**

- Formatage auto à la sauvegarde (VS Code).

- Hooks Git `pre-commit` pour bloquer un code sale.

- Lien qualité / accessibilité du code :
  
  - structure HTML correcte → RGAA
  
  - éviter données inutiles → RGPD

- Contrastes, hiérarchie des titres, attributs `alt`.

**Activités :**

- Mise en place d’un `pre-commit` simple (scripts fournis).

- Corrections HTML/CSS pour rendre un fichier conforme aux bonnes pratiques de base.

**Livrables :**

- Projet configuré avec auto-format + hook Git fonctionnel.

- Page HTML corrigée pour structure + lisibilité + bases RGAA.

---

## **5 TP complet : nettoyer un fichier HTML obfusqué  1 h 30**

Basé sur : *TP_Clean_Code.md* (Holy.html, étapes de réécriture propres)  

**Objectifs :**

- Mettre en pratique l’ensemble des règles vues dans la journée.

- Réécrire totalement un fichier HTML/CSS/JS illisible.

- Produire un code propre, lisible, sans modifier le rendu visuel.

**Consignes inspirées du TP (page “TP Holy.html”) :**

1. **Ré-indenter** tout le fichier (HTML + CSS + JS).

2. **Renommer** classes, IDs, fonctions, variables.

3. **Clarifier** la structure HTML avec sectionnement sémantique.

4. **Nettoyer** le CSS sans toucher au design.

5. **Rendre le JS lisible** (indentation, nommage, commentaires utiles).

**Contraintes :**

- Le rendu **doit rester identique**.

- Les comportements JS doivent **continuer à fonctionner**.

- Aucun morceau de code mort ne doit rester.

**Livrables :**

- Version propre de `Holy.html`, avec :
  
  - HTML lisible, structuré
  
  - CSS compréhensible
  
  - JS clair et nommé correctement
  
  - Fichier validé par au moins un outil (HTML Validator / Prettier / ESLint)

---

# **Résumé clair du déroulé**

1. **Code propre : principes** (45 min)  
   dette technique, lisibilité, 3 styles de code.

2. **Conventions & organisation** (1 h 15)  
   nommage, fonctions courtes, architecture de projet.

3. **Outils de qualité** (1 h 30)  
   linters, formatteurs, analyse statique, validateurs.

4. **Workflow professionnel** (1 h 30)  
   format-on-save, hooks Git, RGAA/RGPD et responsabilité.

5. **TP intégral : Holy.html** (1 h 30)  
   réécriture lisible d’une page obfusquée.
