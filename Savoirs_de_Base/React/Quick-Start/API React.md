# Une API pour REACT

On a deux options solides pour accompagner votre appli React :

1. une petite API REST locale (idéale parce qu’on garde exactement les routes `GET /products` et `POST /products/add` comme dans ton tuto)
2. une API externe type REST Countries (idéale si on veut éviter de mettre en place un backend, mais il n’y a pas de POST donc il faut adapter la partie “ajout”)

---

## Option A - Petite API REST locale (Express) compatible avec ton tuto

Objectif : fournir exactement :

* `GET http://localhost:3000/products`
* `POST http://localhost:3000/products/add`

### 1) Mise en place

Dans un terminal :

```bash
mkdir api-products
cd api-products
npm init -y
npm install express cors
```

Créer un fichier `server.js` :

```js
const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());              // autorise les appels depuis le front (CORS)
app.use(express.json());      // permet de lire le JSON envoyé en POST

// Données en mémoire (on peut les mettre dans un fichier ensuite)
let products = [
  {
    _id: "p1",
    name: "Clavier",
    price: 49.9,
    category: { _id: "c1", name: "Informatique" }
  },
  {
    _id: "p2",
    name: "Souris",
    price: 19.9,
    category: { _id: "c1", name: "Informatique" }
  }
];

// GET /products : renvoie tous les produits
app.get('/products', (req, res) => {
  res.json(products);
});

// POST /products/add : ajoute un produit
app.post('/products/add', (req, res) => {
  const product = req.body;

  // validation minimale
  if (!product?.name || typeof product.price !== 'number' || !product?.category?.name) {
    return res.status(400).json({ message: "Données invalides" });
  }

  // génération d'un id simple côté serveur
  const newProduct = {
    ...product,
    _id: `p${Date.now()}`
  };

  products.push(newProduct);
  res.status(201).json(newProduct);
});

app.listen(3000, () => {
  console.log('API running on http://localhost:3000');
});
```

Lancer l’API :

```bash
node server.js
```

### 2) Test rapide sans Postman (avec curl)

* Lire les produits :

```bash
curl http://localhost:3000/products
```

* Ajouter un produit :

```bash
curl -X POST http://localhost:3000/products/add \
  -H "Content-Type: application/json" \
  -d '{"name":"Ecran","price":120,"category":{"_id":"c2","name":"Bureau"}}'
```

Avantages pédagogiques :

* on garde ton TP React tel quel
* on voit un backend minimal + CORS + JSON
* on évite les surprises d’API externe (quota, changement, champs énormes, etc.)

---

## Option B - Utiliser une API externe (REST Countries)

REST Countries permet de récupérer des pays, par exemple :

* `GET https://restcountries.com/v3.1/all`
* `GET https://restcountries.com/v3.1/name/france`
* `GET https://restcountries.com/v3.1/alpha/fra`
  Ces endpoints sont documentés publiquement. ([restcountries.com][1])

### Important

Cette API est en lecture seule dans notre cas : pas de POST.
Donc on adapte la partie “ajout” en “recherche” ou “filtre”, ce qui reste un TP React très pertinent.

### Adaptation minimale du TP React

#### 1) Type Country

Créer `src/types/country.type.ts` :

```ts
export interface Country {
  name: { common: string }
  capital?: string[]
  region: string
  population: number
  flags?: { png?: string; svg?: string }
}
```

#### 2) Accès API

Créer `src/api/country.api.ts` :

```ts
import { Country } from '../types/country.type'

export async function fetchAllCountries(): Promise<Country[]> {
  const response = await fetch('https://restcountries.com/v3.1/all')
  if (!response.ok) throw new Error('Erreur chargement pays')
  return response.json()
}

export async function searchCountriesByName(name: string): Promise<Country[]> {
  const response = await fetch(`https://restcountries.com/v3.1/name/${encodeURIComponent(name)}`)
  if (!response.ok) throw new Error('Aucun pays trouvé')
  return response.json()
}
```

#### 3) Remplacer “AddProduct” par “SearchCountry”

On fait un formulaire de recherche (champ contrôlé), on appelle `searchCountriesByName`, on affiche les résultats.

Ca reprend exactement les notions React du TP (useState, formulaire, fetch, gestion loading/erreur), sans backend.



[1]: https://restcountries.com/ "REST Countries"
