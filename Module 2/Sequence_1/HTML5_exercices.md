<img src="../../Logo.png" width="550" height="75" alt="logo">

# HTML5 en 10 exercices

## Thème : Location de chalets à la montagne

Objectif : construire pas à pas un petit site HTML statique nommé **"Chalets & Montagne"** en 10 exercices progressifs.  
Technos : uniquement **HTML5**, sans CSS ni JavaScript (on pourra les ajouter plus tard dans un autre module).

Arborescence cible à la fin du mini-projet :

- `index.html`
- `reservation.html`
- `chalets/`
  - `chalet-panorama.html`
- `images/` (pour les fichiers images, même factices au début)

---

## Exercice 1 – Squelette de base (index.html)

Crée un fichier `index.html` avec :

1. Le doctype HTML5.
2. Une balise `<html lang="fr">`.
3. Un `<head>` contenant :
   - `<meta charset="utf-8">`
   - `<meta name="viewport" content="width=device-width, initial-scale=1">`
   - un `<title>` du type : `Chalets & Montagne – Location de chalets`
4. Un `<body>` avec simplement :
   - un `<h1>` : `Chalets & Montagne`
   - un paragraphe `<p>` présentant très brièvement le site (location de chalets pour les vacances à la montagne).

**But :** avoir une page HTML5 **valide** et minimale.

---

## Exercice 2 – Structurer la page d’accueil

Dans `index.html`, complète la structure :

1. Ajoute un `<header>` contenant :
   - le `<h1>` du site,
   - un sous-titre dans un `<p>` (par exemple : `Locations de chalets confortables pour vos séjours à la montagne`).
2. Crée un `<main>` qui contiendra le contenu principal.
3. Ajoute un `<footer>` avec :
   - un texte de copyright (ex : `© 2025 Chalets & Montagne`).

**But :** utiliser les balises structurelles de base (`header`, `main`, `footer`).

---

## Exercice 3 – Navigation principale

Toujours dans `index.html` :

1. Dans le `<header>`, ajoute une navigation `<nav>` contenant une liste `<ul>` de liens `<a>` (certains fichiers n’existent pas encore, ce n’est pas grave) :
   - Accueil (lien vers `index.html`)
   - Nos chalets (lien vers `chalets/chalet-panorama.html`)
   - Réservation (lien vers `reservation.html`)
2. Utilise des textes de lien explicites (éviter “cliquez ici”).

**But :** mettre en place une **navigation cohérente** entre les futures pages.

---

## Exercice 4 – Contenu principal de la page d’accueil

Dans le `<main>` de `index.html` :

1. Crée une section d’introduction avec :
   - `<h2>` : `Pourquoi louer un chalet à la montagne ?`
   - un ou deux paragraphes expliquant les avantages (calme, nature, sports d’hiver, vue, etc.).
2. Ajoute une deuxième section :
   - `<h2>` : `Nos atouts`
   - une liste non ordonnée `<ul>` avec au moins 3 éléments `<li>` (ex : `Chalets tout équipés`, `Proche des pistes`, `Cheminées et spas privatifs`).
3. Ajoute une troisième section :
   - `<h2>` : `Préparer votre séjour`
   - une liste ordonnée `<ol>` avec des étapes (ex : `Choisir vos dates`, `Sélectionner un chalet`, `Remplir le formulaire de réservation`).

**But :** manipuler les titres, paragraphes et listes de manière sémantique.

---

## Exercice 5 – Première page chalet

Crée un dossier `chalets/` et dans ce dossier, un fichier `chalet-panorama.html`.

1. Reprends le squelette de base (doctype, html, head avec charset, viewport, title, etc.).
2. Dans le `<body>`, crée :
   - un `<header>` avec un `<h1>` : `Chalet Panorama`
   - un `<main>` contenant un `<article>`.
3. Dans `<article>` :
   - un `<header>` avec un `<h2>` (sous-titre, ex : `Vue imprenable sur la vallée`) et une date de mise à jour avec `<time datetime="…">`.
   - au moins deux sections `<section>` avec chacune :
     - un `<h3>` (ex : `Description`, `Équipements`, `Accès`),
     - un paragraphe `<p>`.
4. Ajoute un `<footer>` à l’article indiquant, par exemple, `Capacité : 6 personnes – À partir de 1200 € / semaine`.

**But :** apprendre à structurer un **article** de type fiche chalet.

---

## Exercice 6 – Images et figure (photos du chalet)

Dans `chalet-panorama.html` :

1. Ajoute un dossier `images/` à la racine de ton projet (même si les images sont factices au début).

2. Dans `<article>`, insère une première image :

   ```html
   <img
     src="../images/chalet-panorama.jpg"
     alt="Chalet en bois avec balcon et vue sur les montagnes enneigées"
   />
   ```

3. Transforme cette image en bloc illustré :

   ```html
   <figure>
     <img
       src="../images/chalet-panorama.jpg"
       alt="Chalet en bois avec balcon et vue sur les montagnes enneigées"
     />
     <figcaption>Le chalet Panorama, situé à 1500 m d’altitude.</figcaption>
   </figure>
   ```

4. Ajoute une seconde image purement décorative (ex : flocon, motif montagne) et définis `alt=""` pour indiquer qu’elle n’apporte pas d’information essentielle.

**But :** manipuler correctement `<img>`, `alt`, `<figure>` et `<figcaption>` dans le contexte d’un site de location.

---

## Exercice 7 – Page de réservation

Crée un fichier `reservation.html` à la racine du projet.

1. Reprends le squelette complet (doctype, head, etc.) et adapte le `<title>` (`Chalets & Montagne – Réservation`).

2. Dans le `<body>` :

   - un `<header>` avec un `<h1>` : `Demande de réservation`

   - un `<main>` comportant un formulaire `<form>` :

     - attributs `action="#"` et `method="post"` (pour l’instant).

3. Dans le formulaire, ajoute :

   - un champ **Nom** : `<input type="text">` avec label et `required`.
   - un champ **Email** : `<input type="email">` avec label et `required`.
   - un champ **Chalet souhaité** : `<select>` avec au moins 3 options (ex : `Chalet Panorama`, `Chalet Forêt`, `Chalet Neige Éternelle`).
   - deux champs de dates : **Date d’arrivée** et **Date de départ** (`<input type="date">`).
   - un champ **Nombre de personnes** (`<input type="number">` avec `min` approprié).
   - un champ **Commentaire** : `<textarea>`.
   - un bouton `<button type="submit">Envoyer la demande</button>`.

4. Relie correctement chaque `<label>` au champ correspondant (`for` / `id`).

**But :** créer un **formulaire de réservation** simple mais réaliste.

---

## Exercice 8 – Liens internes, coordonnées et contact

Complète le mini-projet :

1. Sur toutes les pages (`index.html`, `chalets/chalet-panorama.html`, `reservation.html`), assure-toi que la navigation `<nav>` est présente et cohérente (liens fonctionnels vers les trois pages principales).

2. Dans `reservation.html`, ajoute une section `Nous contacter` avec :

   - un `<h2>` ;

   - une adresse postale de l’agence au format :

     ```html
     <p>
       Chalets & Montagne<br />
       12 rue des Épicéas<br />
       73000 Station-des-Neiges
     </p>
     ```

   - un lien de type `mailto:` vers une adresse de contact (ex : `contact@chalets-montagne.fr`);

   - éventuellement un lien de type `tel:` pour les réservations par téléphone.

3. Dans `index.html`, ajoute un lien interne qui renvoie directement à la section `Préparer votre séjour` (par exemple en ajoutant un `id` sur le `<h2>` et un lien `<a href="#preparer-sejour">` plus haut dans la page).

**But :** consolider la navigation interne (entre pages et à l’intérieur d’une page).

---

## Exercice 9 – Accessibilité et sémantique

Revois les trois pages :

1. Vérifie que chaque page contient **un seul `<h1>`** pertinent.

2. Assure-toi que les sections ont une hiérarchie logique de titres (`h2`, `h3`, etc.).

3. Ajoute un **lien d’évitement** tout en haut de `index.html` pointant vers `<main>` :

   ```html
   <a href="#contenu-principal">Aller au contenu principal</a>
   <main id="contenu-principal">…</main>
   ```

4. Dans la navigation `<nav>`, ajoute un attribut `aria-label` si c’est pertinent :

   ```html
   <nav aria-label="Navigation principale"></nav>
   ```

5. Vérifie que tous les liens ont un texte **compréhensible hors contexte** (ex : `Voir le chalet Panorama` plutôt que `Voir`).

**But :** améliorer l’**accessibilité** de base du mini-site de location.

---

## Exercice 10 – Validation, cohérence et nettoyage final

Pour terminer le mini-projet :

1. Passe chaque page (`index.html`, `reservation.html`, `chalets/chalet-panorama.html`) dans le **validateur HTML du W3C** et corrige :

   - balises non fermées,
   - attributs manquants ou incorrects,
   - structure invalide (titres, imbrications).

2. Vérifie :

   - que tout le contenu important est dans `<main>` ;
   - que `<header>` et `<footer>` sont utilisés à bon escient ;
   - que les images des chalets ont un `alt` pertinent (ou `alt=""` si décoratives).

3. Ajoute en bas de `index.html` un petit paragraphe indiquant :

   - que le site est un **exercice pédagogique** ;
   - que le code a été vérifié au validateur HTML.

**But :** s’habituer à la **validation**, à la relecture et au nettoyage d’un projet HTML réel, sur un thème professionnel crédible (location de chalets).
