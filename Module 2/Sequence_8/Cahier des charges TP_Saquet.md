# Cahier des charges technique

## TP long – Application web robuste basée sur une API REST

### 1. Objectif général

L’objectif est de concevoir et développer une **application web front-end robuste, accessible et maintenable**, consommant une **API REST sécurisée**, et démontrant un **niveau professionnel**.

Ce projet est destiné à être :

- intégré dans un **portfolio / book de développeur**,

- utilisé comme preuve de compétences techniques et méthodologiques.

Le thème (Tolkien, NASA, météo, etc.) est libre, mais les **exigences techniques sont nécessaires**.

---

### 2. Contraintes générales

- Application **100 % front-end** (HTML / CSS / JavaScript ES)

- Framework JS optionnel (React, Vue ...)

- Librairies CSS autorisées (Bootstrap, Tailwind…)

- Code lisible, structuré, commenté

- Fonctionnement sans serveur backend personnel

---

### 3. Architecture technique attendue

#### 3.1 Structure des fichiers

```texte
/project
 ├── index.html
 ├── /assets
 │    ├── /css
 │    │    ├── main.css
 │    │    └── responsive.css
 │    ├── /js
 │    │    ├── api.js
 │    │    ├── ui.js
 │    │    ├── state.js
 │    │    └── main.js
 │    └── /img
 └── README.md
```

Exigences :

- séparation claire des responsabilités

- aucun JS inline

- imports ES modules conseillé à terme

---

### 4. HTML5 et accessibilité

L’application doit respecter une **structure HTML5 sémantique** :

- `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<footer>`

- hiérarchie des titres cohérente (un seul h1)

- navigation clavier fonctionnelle

- labels associés aux champs de formulaire

- messages d’erreur lisibles par un lecteur d’écran

---

### 5. CSS et responsive design

#### 5.1 Mise en page

- Flexbox et/ou Grid obligatoires

- Responsive mobile / tablette / desktop

- Evitez la dépendance au pixel fixe

#### 5.2 Qualité CSS

- variables CSS (`:root`)

- classes nommées de façon explicite

- pas de duplication inutile

- contraste suffisant (RGAA)

---

### 6. JavaScript ES moderne

#### 6.1 Organisation

- ES modules (`import / export`)

- aucune variable globale exemple :

```JavaScript
function createCounter() {
  let count = 0;
  return () => ++count;
}

const counter = createCounter();
```

- fonctions courtes et lisibles

#### 6.2 DOM

- sélection via `querySelector`

- gestion des événements utilisateur

- mise à jour dynamique de l’interface

---

### 7. Consommation de l’API REST

#### 7.1 Appels réseau

- utilisation de `fetch`

- headers correctement configurés

- lors de la finalisation de l'application pensez au token stocké hors du code (ex: fichier de config ignoré ou variable)

#### 7.2 Gestion des erreurs

Obligatoire :

- erreurs réseau

- erreurs HTTP (401, 404, 500)

- affichage utilisateur clair et non technique

---

### 8. Robustesse de l’application (point clé du TP)

L’application doit démontrer qu’elle est **prévue pour l’échec**.

Exemples attendus :

- message si aucune donnée disponible

- message si API indisponible

- protection contre les clics multiples

- gestion des champs vides ou invalides

- pas de crash JS visible dans la console

---

### 9. Performance et qualité

- images optimisées

- CSS et JS non bloquants

- aucun warning critique en console

---

### 10. Documentation (obligatoire pour un projet de dev sérieux)

Un fichier `README.md` doit contenir :

- description du projet

- fonctionnalités principales

- choix techniques expliqués

- pistes d’amélioration

- lien vers l’API utilisée

**Ce document est le point d'entrée** de votre projet, soignez-le.

---

### 11. Critères de qualité

Le projet est sera considéré comme étant qualitatif si :

- l’application fonctionne sans erreur bloquante

- le code est lisible et structuré

- les erreurs sont gérées

- l’interface est responsive et accessible

- la robustesse est démontrée

- la documentation est complète
