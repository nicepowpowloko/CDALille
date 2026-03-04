<img src="../../Logo.png" width="550" height="75" alt="logo">

# TP HTML/CSS - Chalets & Montagne

Objectif : réaliser en une journée un mini-site vitrine pour un service de location de chalets à la montagne.

## 1. Structure HTML (matin)

Crée la structure suivante dans un dossier de travail :

- `index.html` : page d’accueil
- `reservation.html` : page de demande de réservation
- `chalets/chalet-panorama.html` : fiche détaillée d’un chalet
- `images/` : dossier pour les images (le contenu peut être vide au début)

Chaque page doit :

- utiliser le doctype HTML5 `<!DOCTYPE html>` ;
- avoir `<html lang="fr">` ;
- contenir dans `<head>` :
  - `<meta charset="utf-8">`
  - `<meta name="viewport" content="width=device-width, initial-scale=1">`
  - un `<title>` descriptif ;
- avoir un `<body>` avec :
  - un `<header>` : nom du site + sous-titre + navigation ;
  - un `<main>` : contenu principal de la page ;
  - un `<footer>` : mentions simples (copyright, note pédagogique).

### Page d’accueil (`index.html`)

- Titre du site : `Chalets & Montagne` (dans `<h1>`).
- Sous-titre décrivant le service (location de chalets).
- Navigation avec 3 liens : Accueil, Nos chalets, Réservation.
- Dans `<main>` :
  - une section expliquant pourquoi louer un chalet à la montagne ;
  - une section “Nos atouts” avec une liste non ordonnée ;
  - une section “Préparer votre séjour” avec une liste ordonnée.
- Ajoute un lien d’évitement au tout début de la page :
  `Aller au contenu principal` (ancre vers `<main>`).

### Page fiche chalet (`chalets/chalet-panorama.html`)

- Article `<article>` avec :
  - un titre de chalet (`Chalet Panorama`) ;
  - un sous-titre (`Vue imprenable sur la vallée`) ;
  - une date de mise à jour (`<time>`).
- Sections :
  - “Description” ;
  - “Équipements” (avec une liste) ;
  - “Accès”.
- Une image du chalet avec un texte alternatif pertinent et une légende (`<figure>` / `<figcaption>`).

### Page de réservation (`reservation.html`)

- Un formulaire `<form>` contenant :
  - Nom (texte, requis) ;
  - Email (email, requis) ;
  - Sélecteur de chalet (`<select>`) ;
  - Dates d’arrivée et de départ (`<input type="date">`) ;
  - Nombre de personnes (`<input type="number">`) ;
  - Commentaire (`<textarea>`).
- Chaque champ a un `<label>` associé (`for` / `id`).
- Un bouton pour envoyer la demande.
- Une section “Nous contacter” avec :
  - une adresse postale (avec `<br>`) ;
  - un lien `mailto:` vers l’email de contact ;
  - éventuellement un lien `tel:` pour le téléphone.

## 2. Mise en forme CSS (après-midi)

Crée un fichier `styles.css` et relie-le à chaque page HTML.
L’objectif est de transformer le mini-site en vrai site vitrine lisible.

Points à réaliser :

1. **Réglages de base**

   - Définir `box-sizing: border-box;` sur tous les éléments.
   - Supprimer les marges par défaut du `body`.
   - Choisir une police lisible (ex. `system-ui`) et un fond clair.

2. **Mise en page générale**

   - Utiliser une classe `.container` pour centrer le contenu (max-width, margin auto).
   - Donner un fond coloré au `header` et au `footer` avec un texte clair.

3. **Navigation horizontale**

   - Afficher la liste du menu de navigation en ligne avec Flexbox.
   - Supprimer les puces de la liste.
   - Styliser les liens de navigation (couleurs, hover).

4. **Blocs de contenu sur la page d’accueil**

   - Ajouter un fond blanc, un peu de padding et des coins arrondis pour les sections principales.
   - (Optionnel) Mettre deux sections côte à côte sur les écrans larges avec Flexbox.

5. **Fiche chalet**

   - Styliser l’article du chalet comme une carte (fond blanc, ombre, bordures).
   - Adapter la taille des images pour qu’elles ne dépassent pas du conteneur.

6. **Formulaire de réservation**

   - Empiler proprement les labels et champs (display block, width 100%).
   - Ajouter une légère bordure et du padding aux champs.
   - Styliser le bouton d’envoi comme un bouton principal (fond coloré, texte blanc).

7. **Finitions**

   - Vérifier la lisibilité (contraste, tailles de texte).
   - Tester le site avec la fenêtre étroite pour vérifier le comportement sur petits écrans.
