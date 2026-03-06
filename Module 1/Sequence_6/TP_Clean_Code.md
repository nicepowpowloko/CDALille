<img src="../../Logo.png" width="550" height="75" alt="logo">

## Fiche repère – Les trois styles de code (Fast / OldSchool / Modern)

### Fast.php

Code typique “je fais vite pour que ça tourne” :

- mélange HTML / PHP / JS sans vraie structure,

- indentation irrégulière, noms de variables peu explicites,

- beaucoup de `echo` bruts, peu ou pas de protection (`htmlspecialchars`),

- JS inline (`onclick=...`) et manipulation du DOM un peu sauvage.

Idée principale :  
Ce style est fréquent chez les débutants. Le résultat s’affiche, mais la lisibilité et la maintenabilité sont très faibles. Chaque modification future devient risquée.

---

### OldSchool.php

Code très structuré, avec des séparateurs de commentaires et une organisation très “années 2000” :

- sections massivement commentées et encadrées,

- noms de variables longs mais verbeux,

- JavaScript avec `var`, `type="text/javascript"`, beaucoup de commentaires,

- structure logique claire, mais style global ancien.

Idée principale :  
Le code est lisible et organisé, mais il ne reflète plus les pratiques modernes. On peut s’en inspirer pour la rigueur, pas pour le style.

---

### Modern.php

Code pensé pour être lu en 2025 :

- `declare(strict_types=1);` et petite fonction `escape()` pour sécuriser la sortie HTML,

- noms de variables clairs, `foreach` lisible, syntaxe `<?= … ?>`,

- JavaScript moderne (`type="module"`, `const`, `addEventListener`),

- HTML simple, sans fioritures, bonne séparation des responsabilités.

Idée principale :  
C’est un exemple de code à viser : minimaliste, lisible, sécurisé, moderne, sans sur-commenter. Le code parle de lui-même.

---

## TP – Rendre Holy.html clair et lisible

### Objectif

Vous allez partir d’une page HTML volontairement obfusquée (`Holy.html`) :  
noms de classes illisibles, tout sur une ligne, JavaScript en vrac, etc.

Votre mission : **rendre ce code propre, lisible et maintenable**,  
en gardant **exactement le même rendu** dans le navigateur  
(et les mêmes comportements JavaScript).

---

### Contraintes

- Le rendu visuel doit rester le même.

- Les boutons et les alertes doivent continuer à fonctionner.

- Vous travaillez uniquement sur le code (HTML, CSS, JS), pas sur le design.

---

### Étapes du travail

1. **Ré-indenter et aérer le code**
   
   - remettre des retours à la ligne,
   
   - indenter correctement les balises imbriquées,
   
   - séparer clairement `<head>`, `<body>`, sections, etc.

2. **Renommer les identifiants et classes**
   
   - remplacer les ids/classes du type `#x0`, `.a1`, `.b2` par des noms expressifs,  
     par exemple `.page`, `.header`, `.card-grid`, `.card-title`, etc.
   
   - ne rien changer dans le CSS côté sélection : pensez à faire les renommages de façon cohérente (HTML + CSS).

3. **Clarifier la structure HTML**
   
   - identifier les grandes zones : en-tête, section principale, cartes, liste, footer,
   
   - si besoin, ajouter des commentaires légers pour marquer les grandes sections.

4. **Nettoyer le CSS sans casser le design**
   
   - laisser le style global (couleurs, layout) identique,
   
   - mais regrouper éventuellement les règles qui vont ensemble,
   
   - retirer les répétitions évidentes si vous les repérez.

5. **Rendre le JavaScript plus lisible**
   
   - reformater les fonctions `z0`, `z1`, `z2` (indentation et espaces),
   
   - renommer les paramètres (`x`, `y`, `z`) par des noms compréhensibles,
   
   - ajouter un court commentaire au-dessus de chaque fonction pour dire ce qu’elle fait.

---

### À la fin du TP

Vous devez obtenir une version de `Holy.html` :

- lisible sans effort par un développeur qui débarque sur le projet,

- avec des noms qui décrivent leur rôle,

- avec un HTML structuré, un CSS compréhensible et un JS lisible,

- sans que personne ne voit la différence… côté navigateur.
