<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Déroulé pédagogique – M1 S3**

## Versionner avec Git & Collaborer avec GitHub

---

## **1  Comprendre le versionnement et les principes de Git – 45 min**

**Objectifs :**

* Comprendre pourquoi Git est indispensable dans tout projet moderne.
* Identifier les notions : dépôt, commit, branche, historique.
* Découvrir le rôle de GitHub dans la collaboration (PR, review, merge).

*(Supports : Git – cours général, principes, workflow)*

**Activités :**

* Présentation guidée (tableau comparatif “Sans Git / Avec Git”, p.1–2 du support).

* Démonstration en direct :
  
  * `git status`
  * `git add / commit`
  * `git log` (vue d’historique)

* Mini-quiz oral : « Qu’est-ce qu’un commit ? une branche ? pourquoi ne pas travailler dans main ? ».

**Livrable court :**

* 3 phrases résumant : *ce que Git permet / ce que Git empêche / ce qu’une branche change*.

---

## **2  Premiers pas en ligne de commande – 1 h 15**

Basé sur : *Fiche réflexe Git* et *Cours Git local*

**Objectifs :**

* Initialiser un dépôt local, suivre l’état du projet et versionner proprement.
* Comprendre la boucle de travail : modifier → ajouter → committer.
* Lire ses modifications avant de les enregistrer (bon réflexe professionnel).

**Activités :**

* Exercices guidés dans un dossier de test :
  
  * `git init`
  * création d’un fichier `test.md`,
  * `git add`, `git commit -m`,
  * observation des diffs (`git diff`, `git log`).

* Manipulation de branches :
  
  * création (`git checkout -b feature/...`)
  * navigation (`git checkout main`).

**Notions intégrées :**

* Un commit = une idée
* Nommer proprement ses branches
* Toujours lire l’état (`status`) avant d’agir

**Livrables :**

* 1 dépôt local fonctionnel avec 3 commits cohérents et une branche `feature/nom`.

---

## **3  Collaboration via GitHub & Pull Requests – 1 h 30**

Basé sur : *Support GitHub*, *GitHub CLI*, *TP collaboratif*

**Objectifs :**

* Comprendre le rôle de GitHub dans un workflow d’équipe.
* Savoir cloner un dépôt en ligne, pousser son travail et créer une Pull Request.
* Découvrir la revue de code (review) et l’intégration (merge).

**Contenu abordé :**

* Cloner un dépôt (`git clone`).
* Pousser une branche en ligne (`git push origin feature/...`).
* Connexion GitHub CLI (`gh auth login`).
* Création d’une PR depuis le terminal (`gh pr create`).
* Lecture d’une PR (`gh pr view`), review (`gh pr review`).

**Activités :**

* Mise en pratique :
  
  * Un “responsable” crée le dépôt GitHub (via interface ou `gh repo create`).
  * Les autres le clonent, créent leur branche et y travaillent.
  * Chaque apprenant ouvre une PR vers `dev`, demande une review et attend validation.

* Présentation de l’importance des messages de commit et des titres PR clairs.

**Livrables :**

* 1 branche poussée en ligne
* 1 Pull Request ouverte + 1 review donnée à un pair

---

## **4  Gestion des conflits & workflow d’équipe – 1 h 30**

Basé sur : *TP Collaboratif Git*, *Fiche réflexe Git*, *Cours GitHub*

**Objectifs :**

* Comprendre comment et pourquoi un conflit arrive.
* Apprendre à lire les marqueurs HEAD / incoming branch.
* Résoudre un conflit proprement avant de fusionner.

**Travail à réaliser :**

* TP : deux membres modifient volontairement la même section du fichier `src/index.html` 
  → Push → Conflit.

* Résolution des zones :
  
  ```text
  <<<<<<< HEAD
  ...
  =======
  ...
  >>>>>>> feature/xxx
  ```

* Validation de la résolution (`git add`, `git commit`).

* Fusion finale dans `dev` puis `main` (responsable du dépôt uniquement).

**Livrables :**

* 1 conflit résolu et commité
* Branche fusionnée dans `dev` puis `main`
* Historique lisible (aucun commit “trash”)

---

# **Résumé clair du déroulé**

1. **Introduction au versionnement** (45 min)
   Dépôt, commit, branche, historique + logique Git.

2. **Git local** (1 h 15)
   init → add → commit → branches → log → diff.

3. **GitHub & Pull Requests** (1 h 30)
   clone → push → PR → review → merge.

4. **Conflits & fusion** (1 h 30)
   conflits volontaires, résolution, workflow d’équipe.
