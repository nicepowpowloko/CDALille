<img src="../../Logo.png" width="550" height="75" alt="logo">

# **TP Consommer l’API REST Countries en JavaScript**

## Objectifs pédagogiques

* Découvrir la consommation d’une API REST en JavaScript via `fetch`.
* Manipuler du JSON (objets et tableaux).
* Afficher dynamiquement des données dans une page HTML.
* Mettre en place des filtres (search + région).
* Introduire les notions essentielles pour consommer une API dans un front JS.

---

## 0 Pré-requis techniques

* Créer une page HTML simple.
* Savoir lier un fichier JS avec `<script src="..."></script>`.
* Avoir des bases sur variables, fonctions, tableaux, objets, boucles.

---

## 1 Présentation rapide de l’API REST Countries

L’API REST Countries renvoie des informations sur :
nom, capitale, population, drapeau, région, langues, etc.

```http
https://restcountries.com/v3.1/all?fields=name,capital,region,population,flags
```

---

### Exemple de structure renvoyée

```json
{
  "name": { "common": "France", "official": "French Republic" },
  "capital": ["Paris"],
  "region": "Europe",
  "population": 67391582,
  "flags": {
    "png": "https://flagcdn.com/w320/fr.png"
  }
}
```

---

## 2 Mise en place du projet

Créer un dossier `tp-restcountries` contenant :

* `index.html`
* `style.css`
* `app.js`

---

### Fichier **index.html** (corrigé et fonctionnel)

```html
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <title>TP REST Countries</title>
    <link rel="stylesheet" href="style.css" />
  </head>

  <body>
    <h1>Liste des pays (REST Countries)</h1>

    <section id="controls">
      <input
        type="text"
        id="search"
        placeholder="Rechercher un pays..."
      />

      <select id="region-filter">
        <option value="">Toutes les régions</option>
        <option value="Africa">Africa</option>
        <option value="Americas">Americas</option>
        <option value="Asia">Asia</option>
        <option value="Europe">Europe</option>
        <option value="Oceania">Oceania</option>
      </select>
    </section>

    <section id="countries-container"></section>

    <script src="app.js"></script>
  </body>
</html>
```

---

## 3. Récupérer les données via `fetch`

Dans `app.js` :

### URL

```js
const API_URL =
  "https://restcountries.com/v3.1/all?fields=name,capital,region,population,flags";
```

---

### Exemple minimal

```js
fetch(API_URL)
  .then((response) => {
    if (!response.ok) {
      throw new Error("Erreur HTTP : " + response.status);
    }
    return response.json();
  })
  .then((countries) => {
    console.log("Pays reçus :", countries);
  })
  .catch((error) => {
    console.error("Erreur :", error);
  });
```

Cela permet de vérifier que l’API renvoie bien un tableau.

---

## 4 Afficher les pays dans la page

Version complète :

```js
const API_URL =
  "https://restcountries.com/v3.1/all?fields=name,capital,region,population,flags";

const container = document.getElementById("countries-container");
let allCountries = [];

function fetchCountries() {
  fetch(API_URL)
    .then((response) => {
      if (!response.ok) {
        throw new Error("Erreur HTTP : " + response.status);
      }
      return response.json();
    })
    .then((countries) => {
      allCountries = countries;
      renderCountries(allCountries);
    })
    .catch((error) => {
      console.error("Erreur :", error);
      container.textContent =
        "Impossible de charger les pays. Réessayez plus tard.";
    });
}

function renderCountries(countries) {
  container.innerHTML = "";

  if (!countries || countries.length === 0) {
    container.textContent = "Aucun pays à afficher.";
    return;
  }

  countries.forEach((country) => {
    const name = country.name?.common ?? "Nom inconnu";
    const capital = country.capital?.[0] ?? "Capitale inconnue";
    const region = country.region ?? "Région inconnue";
    const population = country.population?.toLocaleString("fr-FR") ?? "N/A";
    const flag = country.flags?.png ?? "";

    const card = document.createElement("article");
    card.className = "country-card";

    card.innerHTML = `
      <img src="${flag}" alt="Drapeau de ${name}">
      <h2>${name}</h2>
      <p><strong>Capitale :</strong> ${capital}</p>
      <p><strong>Région :</strong> ${region}</p>
      <p><strong>Population :</strong> ${population} habitants</p>
    `;

    container.appendChild(card);
  });
}

fetchCountries();
```

---

## 5 Ajouter la recherche par nom

```js
const searchInput = document.getElementById("search");

searchInput.addEventListener("input", () => {
  const term = searchInput.value.toLowerCase().trim();

  const filtered = allCountries.filter((country) => {
    const name = country.name?.common?.toLowerCase() ?? "";
    return name.includes(term);
  });

  renderCountries(filtered);
});
```

---

## 6 Filtrer par région

```js
const regionSelect = document.getElementById("region-filter");

regionSelect.addEventListener("change", applyFilters);
searchInput.addEventListener("input", applyFilters);

function applyFilters() {
  const term = searchInput.value.toLowerCase().trim();
  const selectedRegion = regionSelect.value;

  let filtered = allCountries;

  if (selectedRegion) {
    filtered = filtered.filter(
      (country) => country.region === selectedRegion
    );
  }

  if (term) {
    filtered = filtered.filter((country) => {
      const name = country.name?.common?.toLowerCase() ?? "";
      return name.includes(term);
    });
  }

  renderCountries(filtered);
}
```

---

## 7 Style CSS (validé)

```css
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 1rem;
  background: #f5f5f5;
}

h1 {
  text-align: center;
}

#controls {
  display: flex;
  gap: 1rem;
  justify-content: center;
  margin: 1rem 0;
}

#controls input,
#controls select {
  padding: 0.5rem;
  font-size: 1rem;
}

#countries-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 1rem;
}

.country-card {
  background: white;
  border-radius: 4px;
  padding: 0.5rem;
  box-shadow: 0 0 4px rgba(0, 0, 0, 0.1);
}

.country-card img {
  width: 100%;
  height: 120px;
  object-fit: cover;
  border-radius: 4px;
}
```
