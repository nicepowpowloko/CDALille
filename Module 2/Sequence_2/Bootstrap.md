<img src="../../Logo.png" width="550" height="75" alt="logo">

# Cours Bootstrap 5.3.8

Bootstrap est une **bibliothèque CSS/JS** conçue pour créer rapidement des interfaces modernes et responsive sans écrire beaucoup de CSS. La version actuelle (**5.3.8**) mise sur :

- un **système de grille puissant**,

- des **composants prêts à l’emploi**,

- des **classes utilitaires**,

- une **meilleure accessibilité**,

- zéro dépendance à jQuery (contrairement à Bootstrap 4).

---

## 1. Installation (CDN)

Ajoute simplement ceci dans `<head>` :

```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
```

Et juste avant `</body>` :

```html
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js"></script>
```

---

## 2. Le système de grille (Grid System)

C’est l’outil principal de Bootstrap.  
Il permet de créer des mises en page responsive en quelques classes.

### Structure

```html
<div class="container">
  <div class="row">
    <div class="col">Col 1</div>
    <div class="col">Col 2</div>
    <div class="col">Col 3</div>
  </div>
</div>
```

### Avec points de rupture responsive

```html
<div class="col-12 col-md-6 col-lg-3">Contenu</div>
```

- `col-12` : sur mobile

- `col-md-6` : sur tablette

- `col-lg-3` : sur large écran

---

## 3. Les classes utilitaires

Bootstrap 5 propose **des centaines de classes** pour styliser sans CSS.

Quelques indispensables :

### Espacements

```html
mt-3   (margin-top)
p-4    (padding)
gap-3  (espacement flex/grid)
```

### Texte

```html
text-center
fw-bold
fst-italic
```

### Couleurs

```html
bg-dark text-white
text-danger
border border-primary
```

### Flexbox

```html
d-flex
justify-content-between
align-items-center
flex-column / flex-row
```

---

## **4. Les composants principaux**

Ci-dessous, 6 composants essentiels à montrer en cours (simples, lisibles, frappants).

### Alertes

```html
<div class="alert alert-success">Opération réussie !</div>
```

### Boutons

```html
<button class="btn btn-primary">Valider</button>
<button class="btn btn-outline-dark">Annuler</button>
```

### Cards (cartes)

```html
<div class="card" style="width: 18rem;">
  <img src="img/chalet.jpg" class="card-img-top" alt="chalet">
  <div class="card-body">
    <h5 class="card-title">Chalet Panorama</h5>
    <p class="card-text">Vue sur la montagne…</p>
    <a href="#" class="btn btn-primary">Voir</a>
  </div>
</div>
```

Parfait pour ton **projet Chalet**.

### Navbar

```html
<nav class="navbar navbar-expand-lg bg-dark navbar-dark">
  <div class="container">
    <a class="navbar-brand" href="#">Chalets</a>
  </div>
</nav>
```

### Modal

```html
<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#info">
  Détails
</button>
```

### Offcanvas (menu latéral moderne)

```html
<button class="btn btn-secondary" data-bs-toggle="offcanvas" data-bs-target="#menu">
  Menu
</button>
```

---

## 5. Le responsive : le vrai cœur de Bootstrap

Tu peux recréer facilement le principe de ton ancien fichier Responsive :

```html
<div class="row g-4">
  <div class="col-12 col-sm-6 col-md-4 col-lg-3 col-xl-2">
    <div class="card">
      <img src="img/p1.jpg" class="card-img-top" alt="">
      <div class="card-body">…</div>
    </div>
  </div>
</div>
```

En 5.3.8, **plus besoin de jQuery** ni de scripts compliqués.

---

## 6. Comportements JavaScript intégrés

Bootstrap 5 utilise **Popper** et son propre bundle :

### Tooltips

```html
<button class="btn btn-secondary" data-bs-toggle="tooltip" title="Info">
  ?
</button>

<script>
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
tooltipTriggerList.forEach(el => new bootstrap.Tooltip(el))
</script>
```

### Popovers

```html
data-bs-toggle="popover"
```

### Collapse (afficher/masquer)

```html
<button data-bs-toggle="collapse" data-bs-target="#bloc">Ouvrir</button>
<div id="bloc" class="collapse">Contenu…</div>
```

---

## 7. Les nouveautés clés par rapport à Bootstrap 4

- Plus de jQuery

- Nouveau système **Grid modernisé**

- Nouveau mode **Dark** automatique avec CSS variables

- Composants plus légers

- Amélioration de l’accessibilité

- Classes utilitaires plus nombreuses
