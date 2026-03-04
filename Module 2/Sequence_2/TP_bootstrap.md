<img src="../../Logo.png" width="550" height="75" alt="logo">

# TP – Passer le site “Chalets & Montagne” en Full Bootstrap 5.3

## Objectif du TP

À partir de votre site HTML/CSS existant (TP Chalets), vous devez :

* intégrer Bootstrap 5.3,
* réorganiser la mise en page avec la grille responsive,
* remplacer les éléments HTML/CSS “maison” par des composants Bootstrap,
* rendre tout le site **responsive mobile → desktop**.

    **Pages à modifier**

* `index.html`
* `reservation.html`
* `chalets/chalet-panorama.html`

---

## Les 10 étapes du TP

---

### 1 Ajouter Bootstrap au projet

Dans chaque page HTML, ajouter dans `<head>` :

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
```

Et avant `</body>` :

```html
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
```

Vérifiez que le site s’affiche toujours.

---

### 2 Transformer le `<header>` en navbar Bootstrap

Remplacer votre navigation par une **navbar responsive**.

Modèle conseillé :

```html
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="#">Chalets & Montagne</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="../index.html">Accueil</a></li>
        <li class="nav-item"><a class="nav-link" href="chalet-panorama.html">Nos chalets</a></li>
        <li class="nav-item"><a class="nav-link" href="../reservation.html">Réservation</a></li>
      </ul>
    </div>
  </div>
</nav>
```

---

### 3 Convertir chaque page en `container` / `row` / `col`

Supprimer les `div` non nécessaires et restructurer ainsi :

```html
<main class="container my-4">
  <div class="row">
    <div class="col-12 col-md-8">
      <!-- contenu -->
    </div>

    <div class="col-12 col-md-4">
      <!-- colonne secondaire -->
    </div>
  </div>
</main>
```

Objectif : avoir une mise en page fluide.

---

### 4 Refaire la fiche chalet en card Bootstrap

Sur `chalet-panorama.html`, remplacer ton bloc principal par :

```html
<div class="card mb-3">
  <img src="../images/chalet1.jpg" class="card-img-top" alt="Chalet Panorama">
  <div class="card-body">
    <h1 class="card-title">Chalet Panorama</h1>
    <p class="card-text"><small class="text-muted">Dernière mise à jour : 2025</small></p>

    <h2>Description</h2>
    <p>...</p>

    <h2>Équipements</h2>
    <ul class="list-group list-group-flush">
      <li class="list-group-item">Wi-Fi</li>
      <li class="list-group-item">Cheminée</li>
      <li class="list-group-item">Spa</li>
    </ul>

    <h2 class="mt-3">Accès</h2>
    <p>...</p>
  </div>
</div>
```

Objectif : une fiche chalet propre, lisible, responsive.

---

### 5 Transformer la page d’accueil en sections Bootstrap

Utiliser par exemple :

```html
<section class="py-4">
  <div class="container">
    <h2 class="mb-3">Pourquoi louer un chalet ?</h2>
    <p>...</p>
  </div>
</section>
```

Ajouter 3 sections (Présentation / Atouts / Préparer votre séjour).

---

### 6 Présenter plusieurs chalets avec des cards en grille

Créer une grille 100% responsive :

```html
<div class="row g-4">
  <div class="col-12 col-md-6 col-lg-4">
    <div class="card">
      <img src="images/chalet1.jpg" class="card-img-top" alt="">
      <div class="card-body">
        <h5 class="card-title">Chalet Panorama</h5>
        <a href="chalets/chalet-panorama.html" class="btn btn-primary">Voir</a>
      </div>
    </div>
  </div>
</div>
```

Automatique mobile → tablette → desktop.

---

### 7 Refaire le formulaire en Bootstrap

Dans `reservation.html`, remplacer ton formulaire par :

```html
<form class="row g-3">
  <div class="col-md-6">
    <label class="form-label">Nom</label>
    <input type="text" class="form-control" required>
  </div>

  <div class="col-md-6">
    <label class="form-label">Email</label>
    <input type="email" class="form-control" required>
  </div>

  <div class="col-12">
    <label class="form-label">Commentaire</label>
    <textarea class="form-control"></textarea>
  </div>

  <div class="col-12">
    <button class="btn btn-primary">Envoyer</button>
  </div>
</form>
```

Objectif : formulaire propre + compatible mobile.

---

### 8 Ajouter du spacing (espacements)

Bootstrap utilise :

* `my-4` → margin vertical
* `py-5` → padding vertical
* `g-3` → gap entre colonnes

Objectif : espacer proprement les sections et les colonnes.

---

### 9 Tester la version mobile

Dans Chrome/Firefox :
→ Inspect → Mode appareil → iPhone SE / iPad / Desktop
Vérifier :

* navbar qui se replie
* cards qui passent en une colonne
* texte restant lisible
* formulaire utilisable sur mobile

---

### 10 Nettoyer les anciens styles CSS

Une fois Bootstrap bien intégré :

* supprimer les marges inutiles
* retirer les styles CSS qui doublonnent Bootstrap
* garder uniquement vos personnalisations

Objectif : un site propre, moderne, léger.

---

## Résultat final attendu

À la fin du TP, le mini-site “Chalets & Montagne” doit :

* être **100 % responsive**,
* utiliser **exclusivement Bootstrap** pour la structure,
* avoir des cards, une navbar, un formulaire Bootstrap,
* être propre visuellement et lisible sur mobile.