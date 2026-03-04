<img src="../../Logo.png" width="550" height="75" alt="logo">

# CSS3 en 10 exercices

## Thème : Location de chalets à la montagne (le retour ...)

Objectif : ajouter progressivement une feuille de style `styles.css` au mini-site **"Chalets & Montagne"** déjà réalisé en HTML.

Prérequis :  
Le projet HTML contient au minimum :

- `index.html`
- `reservation.html`
- `chalets/chalet-panorama.html`
- `images/…` (images réelles ou factices)

Tous les fichiers HTML doivent maintenant lier la même feuille de style :

```html
<link rel="stylesheet" href="styles.css" />
```

_(dans `chalet-panorama.html`, adapter le chemin si besoin : `../styles.css`)_

---

## Exercice 1 – Brancher la feuille CSS et régler la base

1. Crée un fichier `styles.css` à la racine du projet.
2. Vérifie que chaque page HTML y fait bien référence :

   - `index.html` → `<link rel="stylesheet" href="styles.css">`
   - `reservation.html` → idem
   - `chalets/chalet-panorama.html` → `<link rel="stylesheet" href="../styles.css">`

3. Dans `styles.css`, ajoute :

   ```css
   /* Réglages de base */
   * {
     box-sizing: border-box;
   }

   html {
     font-size: 16px;
   }

   body {
     margin: 0;
     font-family: system-ui, -apple-system, "Segoe UI", Roboto, Arial, sans-serif;
     line-height: 1.6;
     color: #1f2933; /* gris foncé lisible */
     background: #f5f7fa; /* gris très clair */
   }
   ```

**But :** connecter proprement la feuille CSS et définir une base typographique globale.

---

## Exercice 2 – Typographie et hiérarchie visuelle

Objectif : rendre les titres et les textes plus lisibles et structurés.

1. Dans `styles.css`, ajoute des styles pour :

   ```css
   h1,
   h2,
   h3 {
     font-family: system-ui, -apple-system, "Segoe UI", Roboto, Arial, sans-serif;
     margin-top: 0;
   }

   h1 {
     font-size: 2.2rem;
     letter-spacing: 0.05em;
   }

   h2 {
     font-size: 1.6rem;
     margin-top: 2rem;
   }

   h3 {
     font-size: 1.3rem;
     margin-top: 1.5rem;
   }

   p {
     margin: 0.75rem 0;
   }

   ul,
   ol {
     padding-left: 1.5rem;
     margin: 0.75rem 0;
   }
   ```

2. Vérifie sur les 3 pages que :

   - les titres ressortent clairement,
   - les listes sont lisibles,
   - les paragraphes ont assez d’espace.

**But :** installer une hiérarchie visuelle cohérente entre titres, paragraphes et listes.

---

## Exercice 3 – Structurer la mise en page (conteneur principal)

On va centrer le contenu et lui donner un max-width confortable.

1. Ajoute une classe `class="container"` autour du contenu principal dans les pages HTML, par exemple :

   ```html
   <body>
     <div class="container">
       <header>…</header>
       <main>…</main>
       <footer>…</footer>
     </div>
   </body>
   ```

2. Dans `styles.css`, ajoute :

   ```css
   .container {
     max-width: 960px;
     margin: 0 auto;
     padding: 0 1rem 2rem;
   }
   ```

3. Donne un fond différent au `<header>` et au `<footer>` :

   ```css
   header {
     background: #0b3d91; /* bleu nuit */
     color: #ffffff;
     padding: 1rem 0;
     margin-bottom: 1.5rem;
   }

   footer {
     background: #102a43; /* bleu/gris foncé */
     color: #d9e2ec;
     padding: 1rem 0;
     margin-top: 2rem;
     font-size: 0.9rem;
     text-align: center;
   }
   ```

**But :** obtenir une structure de page plus “site web” que simple texte brut.

---

## Exercice 4 – Navigation principale en ligne

On va transformer la liste du `<nav>` en menu horizontal.

1. Ajoute, dans le HTML (si ce n’est pas déjà fait), une classe sur la navigation :

   ```html
   <nav class="nav-principale" aria-label="Navigation principale">
     <ul>
       <li><a href="index.html">Accueil</a></li>
       <li><a href="chalets/chalet-panorama.html">Nos chalets</a></li>
       <li><a href="reservation.html">Réservation</a></li>
     </ul>
   </nav>
   ```

2. Dans `styles.css`, ajoute :

   ```css
   .nav-principale ul {
     list-style: none;
     margin: 0;
     padding: 0;
     display: flex;
     gap: 1.5rem;
     align-items: center;
   }

   .nav-principale a {
     color: #e0f2ff;
     text-decoration: none;
     font-weight: 500;
   }

   .nav-principale a:hover,
   .nav-principale a:focus {
     text-decoration: underline;
   }
   ```

3. Ajuste le `<header>` pour centrer ou aligner le contenu :

   ```css
   header .container {
     display: flex;
     flex-direction: column;
     gap: 0.5rem;
   }

   @media (min-width: 768px) {
     header .container {
       flex-direction: row;
       justify-content: space-between;
       align-items: center;
     }
   }
   ```

**But :** créer un menu horizontal simple, responsive, sans JavaScript.

---

## Exercice 5 – Bloc “intro” et sections de la page d’accueil

On améliore la lisibilité des sections de `index.html`.

1. Dans `index.html`, ajoute des classes sémantiques si besoin, par exemple :

   ```html
   <section class="intro-site">…</section>

   <section class="section-atouts">…</section>

   <section class="section-preparer">…</section>
   ```

2. Dans `styles.css`, ajoute :

   ```css
   .intro-site {
     background: #ffffff;
     padding: 1.5rem;
     border-radius: 0.5rem;
     box-shadow: 0 2px 4px rgba(15, 23, 42, 0.08);
     margin-bottom: 1.5rem;
   }

   .section-atouts,
   .section-preparer {
     background: #ffffff;
     padding: 1.25rem;
     border-radius: 0.5rem;
     margin-top: 1.5rem;
   }

   .section-atouts ul li::marker {
     color: #0b3d91;
   }

   .section-preparer ol li::marker {
     color: #d97706; /* orange */
     font-weight: 600;
   }
   ```

3. Vérifie que la page d’accueil ressemble maintenant à de vrais “blocs” de contenu.

**But :** apprendre à structurer visuellement des sections avec fonds, bordures et ombres légères.

---

## Exercice 6 – Mise en page du chalet (fiche détaillée)

On stylise la fiche `chalet-panorama.html`.

1. Dans le HTML, ajoute une classe sur l’article :

   ```html
   <article class="fiche-chalet">…</article>
   ```

2. Dans `styles.css`, ajoute :

   ```css
   .fiche-chalet {
     background: #ffffff;
     padding: 1.5rem;
     border-radius: 0.75rem;
     box-shadow: 0 4px 8px rgba(15, 23, 42, 0.12);
   }

   .fiche-chalet header {
     margin-bottom: 1rem;
   }

   .fiche-chalet time {
     font-size: 0.9rem;
     color: #62748a;
   }

   .fiche-chalet footer {
     margin-top: 1.5rem;
     padding-top: 1rem;
     border-top: 1px solid #d9e2ec;
     background: transparent;
     text-align: right;
     color: #334e68;
   }
   ```

3. Stylise aussi la figure avec l’image du chalet :

   ```css
   .fiche-chalet figure {
     margin: 1rem 0;
   }

   .fiche-chalet img {
     max-width: 100%;
     display: block;
     border-radius: 0.75rem;
   }

   .fiche-chalet figcaption {
     font-size: 0.9rem;
     color: #52606d;
     margin-top: 0.5rem;
   }
   ```

**But :** construire une vraie “carte produit” pour un chalet, visuellement claire.

---

## Exercice 7 – Formulaire de réservation lisible et aligné

On stylise le formulaire de `reservation.html`.

1. Dans `reservation.html`, ajoute une classe autour du formulaire :

   ```html
   <main>
     <section class="bloc-formulaire">
       <h2>Réserver votre séjour</h2>
       <form class="form-reservation" action="#" method="post">…</form>
     </section>
   </main>
   ```

2. Dans `styles.css`, ajoute :

   ```css
   .bloc-formulaire {
     background: #ffffff;
     padding: 1.5rem;
     border-radius: 0.75rem;
     box-shadow: 0 2px 6px rgba(15, 23, 42, 0.1);
   }

   .form-reservation {
     display: grid;
     gap: 1rem;
   }

   .form-reservation label {
     display: block;
     font-weight: 500;
     margin-bottom: 0.25rem;
   }

   .form-reservation input,
   .form-reservation select,
   .form-reservation textarea {
     width: 100%;
     padding: 0.5rem 0.75rem;
     border-radius: 0.5rem;
     border: 1px solid #cbd2e1;
     font: inherit;
   }

   .form-reservation textarea {
     min-height: 120px;
     resize: vertical;
   }

   .form-reservation button[type="submit"] {
     background: #0b3d91;
     color: #ffffff;
     border: none;
     border-radius: 9999px;
     padding: 0.6rem 1.5rem;
     font-weight: 600;
     cursor: pointer;
   }

   .form-reservation button[type="submit"]:hover,
   .form-reservation button[type="submit"]:focus {
     background: #0f509f;
   }
   ```

**But :** rendre un formulaire utilisable, lisible, agréable sans framework.

---

## Exercice 8 – Mise en page responsive simple

On va adapter la mise en page pour les écrans plus larges.

1. Dans `index.html`, si ce n’est pas déjà fait, regroupe les sections “Nos atouts” et “Préparer votre séjour” dans un conteneur :

   ```html
   <div class="layout-accueil">
     <section class="section-atouts">…</section>
     <section class="section-preparer">…</section>
   </div>
   ```

2. Dans `styles.css`, ajoute :

   ```css
   .layout-accueil {
     display: flex;
     flex-direction: column;
     gap: 1.5rem;
     margin-top: 1.5rem;
   }

   @media (min-width: 768px) {
     .layout-accueil {
       flex-direction: row;
       align-items: flex-start;
     }

     .section-atouts,
     .section-preparer {
       flex: 1 1 0;
     }
   }
   ```

3. Vérifie le rendu :

   - sur mobile : sections l’une sous l’autre ;
   - sur écran plus large : sections côte à côte.

**But :** introduire une **mise en page responsive** simple avec Flexbox.

---

## Exercice 9 – États au survol et liens plus engageants

On améliore l’interaction utilisateur.

1. Ajoute des styles globaux pour tous les liens :

   ```css
   a {
     color: #0b3d91;
   }

   a:hover,
   a:focus {
     color: #1c64f2;
   }
   ```

2. Dans les listes d’articles/atouts, ajoute un effet survol :

   ```css
   .section-atouts li,
   .section-preparer li {
     transition: background-color 0.15s ease, transform 0.15s ease;
   }

   .section-atouts li:hover,
   .section-preparer li:hover {
     background: #f0f4ff;
     transform: translateX(2px);
   }
   ```

3. Si tu as un lien du type “Voir le chalet Panorama”, stylise-le comme un bouton :

   ```css
   .lien-bouton {
     display: inline-block;
     padding: 0.5rem 1rem;
     border-radius: 9999px;
     background: #0b3d91;
     color: #ffffff;
     text-decoration: none;
     font-weight: 500;
   }

   .lien-bouton:hover,
   .lien-bouton:focus {
     background: #1c64f2;
   }
   ```

**But :** donner un peu de “vie” au site sans exagérer, tout en respectant l’accessibilité.

---

## Exercice 10 – Nettoyage, cohérence visuelle et check final

1. Vérifie dans `styles.css` :

   - qu’il n’y a pas de doublons évidents,
   - que les couleurs restent cohérentes avec le thème “montagne / chalet” (bleus, blancs, bois…),
   - que les tailles de texte restent raisonnables.

2. Ajoute, si tu le souhaites, une **petite palette de couleurs commentée** en haut du fichier :

   ```css
   /* Palette
      Bleu nuit:   #0b3d91
      Bleu clair:  #1c64f2
      Fond clair:  #f5f7fa
      Texte:       #1f2933
   */
   ```

3. Ouvre le site :

   - sur un écran large,
   - en réduisant la fenêtre comme sur un mobile.

4. Corrige les détails gênants :

   - marges trop grandes ou trop petites,
   - texte qui touche les bords,
   - liens difficiles à distinguer.

**But :** apprendre à “finir” un mini-projet CSS : cohérence, lisibilité, pas de bricolage.
