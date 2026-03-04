# TP React - Consommer une API REST avec Vite et TypeScript

## 1. Objectifs du TP

Dans ce TP, on va :

* installer l’environnement nécessaire pour travailler avec React ;
* créer une application React moderne avec Vite et TypeScript ;
* consommer une API REST qui expose des produits ;
* afficher la liste des produits reçus depuis l’API ;
* ajouter un produit via un formulaire ;
* structurer un projet React de manière propre (dossiers, typage, séparation de la logique et de l’affichage).

Ce TP est conçu pour être réalisé en autonomie sur une journée.

---

## 2. Pré-requis

* Savoir utiliser un terminal (shell, PowerShell, etc.) ;
* Avoir quelques bases en JavaScript (variables, fonctions, objets) ;
* Comprendre la notion de requête HTTP (GET, POST) ;
* Disposer d’une API disponible à l’adresse :

```text
http://localhost:3000/products
```

Cette API doit au minimum :

* répondre à `GET /products` en renvoyant la liste des produits ;
* accepter `POST /products/add` pour ajouter un produit.

---

## 3. Installation de Node.js et npm

### 3.1. Pourquoi ne pas utiliser APT sur Linux

Sur Debian, Ubuntu et dérivés, les dépôts APT proposent souvent des versions de Node.js assez anciennes.
Pour travailler avec React et Vite, il est préférable d’avoir une version récente de Node LTS.

On va donc installer Node.js depuis le site officiel, et non via `apt`.

### 3.2. Installation depuis le site officiel

1. On ouvre un navigateur web.
2. On se rend sur le site officiel :
   `https://nodejs.org`
3. On télécharge la version LTS (celle recommandée).
4. On lance l’installateur et on suit les étapes par défaut.

Sur Linux, on peut aussi utiliser les archives officielles ou un gestionnaire comme nvm, mais dans le cadre de ce TP, on se contente de l’installateur indiqué sur le site officiel ou de la procédure recommandée sur ce même site.

### 3.3. Vérification de l’installation

Dans un terminal, on tape :

```bash
node -v
npm -v
```

On doit obtenir deux numéros de version, par exemple :

```text
v20.11.0
10.5.0
```

Si ce n’est pas le cas, il faut corriger l’installation de Node.js avant de continuer.

---

## 4. Création du projet React avec Vite et TypeScript

### 4.1. Création du squelette

Dans un terminal, on se place dans le dossier où on souhaite créer le projet, puis on tape :

```bash
npm create vite@latest front-react
```

Vite pose plusieurs questions :

* Framework à utiliser : on choisit `React`.
* Variante : on choisit `TypeScript`.

Vite affiche une URL (par défaut `http://localhost:5173`).
On ouvre cette URL dans le navigateur et on doit voir l’écran d’accueil de Vite + React.

Si on choisit de ne pas utiliser Vite jusqu'au bout de la démarche, on peu se déplacer dans le répertoire :

```bash
cd front-react
```

On installe les dépendances :

```bash
npm install
```

Puis on lance le serveur de développement :

```bash
npm run dev
```

---

## 5. Nettoyage du projet de base

Le projet généré contient du code de démonstration qui ne nous intéresse pas.

On va simplifier pour repartir d’une base minimale.

### 5.1. Fichiers à nettoyer

Dans le dossier `src` :

* on peut supprimer `App.css` (facultatif si on ne l’utilise pas) ;
* on ouvre `App.tsx` et on supprime tout le contenu.

On garde `main.tsx` tel quel pour l’instant.

### 5.2. Nouveau contenu minimal de `App.tsx`

Fichier: `src/App.tsx`

```tsx
export default function App() {
  return <h1>TP React - Produits</h1>
}
```

À ce stade, si on relance la page dans le navigateur, on doit voir simplement le titre `TP React - Produits`.

---

## 6. Structuration du projet

Pour garder une application lisible, on va organiser le code en plusieurs dossiers :

Dans `src`, on crée les dossiers suivants :

```text
src/
├── api/
├── components/
├── pages/
├── types/
```

* `types` contiendra les interfaces TypeScript qui décrivent les données.
* `api` regroupera les fonctions qui font des appels HTTP vers l’API.
* `components` contiendra les composants d’affichage réutilisables.
* `pages` servira éventuellement à créer des pages complètes (utilisées par le router).

Cette structuration est une bonne habitude pour des projets réels.

---

## 7. Définition des types TypeScript

On commence par décrire la forme des données que l’on reçoit et que l’on envoie à l’API.

On suppose que chaque produit a :

* un identifiant `_id` (optionnel côté front, car il peut être créé par le backend) ;
* un nom `name` ;
* un prix `price` (nombre) ;
* une catégorie `category` avec un identifiant et un nom.

### 7.1. Fichier des types

Fichier: `src/types/product.type.ts`

```ts
export interface Category {
  _id: string
  name: string
}

export interface Product {
  _id?: string
  name: string
  price: number
  category: Category
}
```

Explications :

* `Category` représente une catégorie de produit.
* `Product` représente un produit complet.
* `_id` est marqué comme optionnel (`_id?`) car quand on crée un nouveau produit côté front, on peut ne pas encore connaître son identifiant exact (il peut être généré côté serveur).

---

## 8. Module d’accès à l’API

On veut regrouper toutes les interactions avec l’API dans un module dédié.

### 8.1. Fichier `product.api.ts`

Fichier: `src/api/product.api.ts`

```ts
import type { Product } from '../types/product.type'

// URL de base de notre API de produits
const API_URL = 'http://localhost:3000/products'

// Récupérer la liste des produits (GET /products)
export async function fetchProducts(): Promise<Product[]> {
  const response = await fetch(API_URL)

  if (!response.ok) {
    // Si le code HTTP n'est pas 2xx, on considère qu'il y a une erreur
    throw new Error('Erreur lors du chargement des produits')
  }

  // on parse la réponse JSON et on la retourne sous forme de tableau de Product
  return response.json()
}

// Ajouter un produit (POST /products/add)
export async function addProduct(product: Product): Promise<Product> {
  const response = await fetch(`${API_URL}/add`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(product),
  })

  if (!response.ok) {
    throw new Error('Erreur lors de l’ajout du produit')
  }

  return response.json()
}
```

Points importants :

* `fetch` renvoie une promesse qui contient un objet `Response`.
* On teste `response.ok` pour vérifier le code HTTP (2xx).
* En cas de problème, on lève une erreur avec `throw new Error(...)`.
* On indique un type de retour précis (`Promise<Product[]>` ou `Promise<Product>`).

---

## 9. Afficher la liste des produits

On va maintenant créer un composant React qui :

* charge la liste des produits au montage du composant ;
* affiche un message pendant le chargement ;
* affiche un message en cas d’erreur ;
* affiche la liste des produits quand tout va bien.

### 9.1. Création du composant `ProductList`

Fichier: `src/components/ProductList.tsx`

```tsx
import { useEffect, useState } from 'react'
import { fetchProducts } from '../api/product.api'
import type { Product } from '../types/product.type'

export default function ProductList() {
  // état pour stocker les produits
  const [products, setProducts] = useState<Product[]>([])
  // état pour indiquer si on est en train de charger
  const [loading, setLoading] = useState(true)
  // état pour stocker un éventuel message d’erreur
  const [error, setError] = useState<string | null>(null)

  // useEffect avec un tableau de dépendances vide
  // signifie: exécuter ce code une seule fois au montage du composant
  useEffect(() => {
    fetchProducts()
      .then(data => {
        setProducts(data)
      })
      .catch(err => {
        setError(err.message)
      })
      .finally(() => {
        setLoading(false)
      })
  }, [])

  if (loading) {
    return <p>Chargement des produits...</p>
  }

  if (error) {
    return <p style={{ color: 'red' }}>{error}</p>
  }

  if (products.length === 0) {
    return <p>Aucun produit trouvé.</p>
  }

  return (
    <ul>
      {products.map(product => (
        <li key={product._id}>
          {product.name} - {product.price} € ({product.category.name})
        </li>
      ))}
    </ul>
  )
}
```

Explications :

* `useState` permet de créer des états locaux au composant.
* `useEffect` permet de déclencher du code "effet de bord" (appel API) au moment souhaité.
* Ici, on appelle `fetchProducts` au chargement du composant.
* Une fois les données reçues, on les stocke dans `products`.
* React re-render automatiquement l’affichage dès que l’état change.

---

## 10. Formulaire d’ajout de produit

On souhaite permettre l’ajout d’un produit via un formulaire simple qui contient :

* un champ texte pour le nom ;
* un champ numérique pour le prix ;
* un champ texte pour la catégorie.

### 10.1. Composant `AddProduct`

Fichier: `src/components/AddProduct.tsx`

```tsx
import { useState } from 'react'
import { addProduct } from '../api/product.api'
import type { Product } from '../types/product.type'

export default function AddProduct() {
  const [name, setName] = useState('')
  const [price, setPrice] = useState(0)
  const [categoryName, setCategoryName] = useState('')

  const [message, setMessage] = useState<string | null>(null)
  const [error, setError] = useState<string | null>(null)

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault() // on empêche le rechargement de la page

    setMessage(null)
    setError(null)

    // Construction de l’objet Product à envoyer
    const product: Product = {
      name,
      price,
      category: {
        // on génère un identifiant local pour la catégorie
        _id: crypto.randomUUID(),
        name: categoryName,
      },
    }

    try {
      await addProduct(product)
      setMessage('Produit ajouté avec succès')
      // on réinitialise les champs
      setName('')
      setPrice(0)
      setCategoryName('')
    } catch (err: any) {
      setError(err.message ?? 'Erreur inconnue')
    }
  }

  return (
    <div>
      <h2>Ajouter un produit</h2>

      <form onSubmit={handleSubmit}>
        <div>
          <label>
            Nom du produit :
            <input
              type="text"
              value={name}
              onChange={event => setName(event.target.value)}
              required
            />
          </label>
        </div>

        <div>
          <label>
            Prix :
            <input
              type="number"
              value={price}
              onChange={event => setPrice(Number(event.target.value))}
              required
            />
          </label>
        </div>

        <div>
          <label>
            Catégorie :
            <input
              type="text"
              value={categoryName}
              onChange={event => setCategoryName(event.target.value)}
              required
            />
          </label>
        </div>

        <button type="submit">Ajouter</button>
      </form>

      {message && <p style={{ color: 'green' }}>{message}</p>}
      {error && <p style={{ color: 'red' }}>{error}</p>}
    </div>
  )
}
```

Points importants :

* On utilise des "champs contrôlés" : la valeur du champ vient de l’état React, et chaque modification met à jour cet état.
* On construit ensuite un objet `Product` cohérent avec notre type TypeScript.
* On appelle `addProduct` qui envoie la requête POST vers l’API.

---

## 11. Mise en place du routage

Pour naviguer entre la liste des produits et le formulaire d’ajout, on va utiliser React Router.

### 11.1. Installation de React Router

Dans le projet, on installe la dépendance :

```bash
npm install react-router-dom
```

### 11.2. Mise à jour de `App.tsx`

Fichier: `src/App.tsx`

```tsx
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom'
import ProductList from './components/ProductList'
import AddProduct from './components/AddProduct'

export default function App() {
  return (
    <BrowserRouter>
      <header>
        <h1>TP React - Produits</h1>
        <nav>
          <Link to="/">Liste des produits</Link> |{' '}
          <Link to="/add">Ajouter un produit</Link>
        </nav>
      </header>

      <main>
        <Routes>
          <Route path="/" element={<ProductList />} />
          <Route path="/add" element={<AddProduct />} />
        </Routes>
      </main>
    </BrowserRouter>
  )
}
```

Explications :

* `BrowserRouter` encapsule l’application et gère l’historique du navigateur.
* `Routes` contient l’ensemble des routes possibles.
* `Route path="/"` affiche `ProductList` à la racine.
* `Route path="/add"` affiche `AddProduct` pour l’URL `/add`.
* `Link` permet de naviguer sans recharger la page.

---

## 12. Vérifications finales

Pour vérifier que tout fonctionne, on suit les étapes suivantes :

1. Lancer le serveur front :
   
   ```bash
   npm run dev
   ```

2. Vérifier que l’API backend est bien démarrée et disponible sur `http://localhost:3000/products`.

3. Aller sur `http://localhost:5173` dans le navigateur.

4. Sur la page d’accueil, on doit voir le titre et la liste des produits (ou un message indiquant qu’il n’y en a pas).

5. Cliquer sur "Ajouter un produit".

6. Remplir le formulaire et valider.

7. Revenir sur la liste des produits et vérifier que le nouveau produit est présent (selon la logique de l’API, un rafraîchissement de la page peut être nécessaire si on ne recalcule pas la liste automatiquement).

---

## 13. Pistes d’amélioration (si on a le temps)

Pour aller plus loin, on peut :

* Rafraîchir automatiquement la liste des produits après l’ajout (par exemple en remontant l’état dans un composant parent).
* Ajouter une gestion plus fine des erreurs (affichage d’un code de statut ou d’un message provenant du backend).
* Ajouter des styles avec un fichier CSS ou un framework CSS (Tailwind, Bootstrap, etc.).
* Créer un composant `ProductItem` pour afficher un produit et éviter de répéter du code.
* Créer un hook personnalisé `useProducts` pour rassembler toute la logique de chargement des produits (appel API, loading, erreur, etc.).
