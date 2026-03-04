# Intégrer React dans Symfony avec Webpack Encore (document complet)

Objectif : comprendre le rôle de Webpack Encore, puis mettre en place React dans un projet Symfony en gardant Symfony comme “back” (routing, sécurité, templates) et React comme “front” (UI dynamique).  
Ce document couvre : concepts, installation, architecture, transfert de données, organisation du code, build dev/prod, pièges classiques.

---

## 1) Webpack Encore : c’est quoi, et pourquoi Symfony l’utilise ?

### 1.1 Le problème à résoudre

Dès que tu fais du front moderne, tu as souvent besoin de :

- regrouper plusieurs fichiers JS/CSS en bundles,
- compiler du code (TypeScript, JSX React),
- transformer du CSS (Sass, PostCSS),
- optimiser pour la prod (minification, cache busting),
- gérer des assets (images, fonts),
- fournir un serveur de dev (hot reload selon setup).

Webpack fait tout ça, mais sa configuration “pure” est verbeuse et intimidante.

### 1.2 La promesse de Webpack Encore

Webpack Encore est une surcouche “DX-friendly” qui simplifie la config Webpack et s’intègre bien avec Symfony.

En pratique, Encore te donne :

- une API fluide dans `webpack.config.js` (enableReactPreset, enableTypeScriptLoader, splitEntryChunks, etc.),
- des conventions Symfony (dossier `assets/`, sortie `public/build/`),
- des helpers Twig pour inclure les bundles (`encore_entry_script_tags`, `encore_entry_link_tags`),
- un workflow dev/prod propre.

### 1.3 Le vocabulaire important

- **Entry (point d’entrée)** : fichier racine à compiler (ex : `assets/app.js`).  
  Un projet peut avoir plusieurs entries (ex : `app`, `admin`, `landing`).
- **Bundle** : résultat compilé (JS/CSS) placé dans `public/build/`.
- **Loader** : “traducteur” Webpack (ex : TS -> JS, JSX -> JS).
- **Preset React** : configuration qui active Babel/JSX et les réglages utiles à React.
- **Versioning** : ajoute un hash aux fichiers build pour forcer le cache busting en prod.

---

## 2) Choisir une architecture React dans Symfony

Il y a 3 approches principales. Le choix impacte tout (routing, data, SEO, complexité).

### A) “Widget React” dans une page Twig (intégration progressive)

Symfony sert la page Twig, React rend une partie de la page dans une div root.

Avantages :

- simple à démarrer,
- Symfony conserve le routing,
- parfait pour ajouter de l’interactivité ponctuelle.

Inconvénients :

- si l’app devient énorme, tu peux finir avec beaucoup de zones React.

### B) “SPA React” servie par Symfony (une seule page Twig)

Symfony sert une page unique (ex : `/app`), React gère le routing côté client (React Router).

Avantages :

- expérience SPA, UI très fluide,
- côté React tout est cohérent.

Inconvénients :

- SEO et rendu initial (à traiter si besoin),
- il faut penser auth/API proprement.

### C) Symfony en API + front séparé (Vite/Next à côté)

C’est un autre monde (déploiement, CORS, tokens).  
Possible, mais ce document se concentre sur “React dans Symfony” via Encore.

---

## 3) Pré-requis et conventions conseillées

### 3.1 Version Node

Recommandation : installer Node depuis le site officiel (ou via nvm), pas via un vieux paquet APT qui peut être daté.

### 3.2 Structure de dossiers (recommandée)

Dans un Symfony standard :

- `assets/` : sources front (JS/TS/CSS/React)
- `public/build/` : sortie compilée (générée)
- `templates/` : Twig

Exemple conseillé :

- `assets/entries/app.tsx` (entry principale)
- `assets/react/App.tsx` (racine React)
- `assets/react/pages/`
- `assets/react/components/`
- `assets/react/services/` (fetch/api client)
- `assets/styles/app.css` (ou scss)

---

## 4) Mise en place technique étape par étape (React dans Symfony)

### 4.1 Installer les dépendances

Dans ton projet Symfony :

React :

```bash
npm install react react-dom
```

Babel preset React via Encore (souvent déjà dans un projet Symfony récent, sinon) :

```bash
npm install --save-dev @symfony/webpack-encore
```

Si tu veux TypeScript (recommandé en 2026 pour un TP “propre”) :

```bash
npm install --save-dev typescript @types/react @types/react-dom
```

### 4.2 Activer React (et TypeScript si besoin) dans `webpack.config.js`

Dans `webpack.config.js`, tu veux au minimum :

```js
// ...
Encore
  // ...
  .enableReactPreset()
;
```

Si TypeScript :

```js
.enableTypeScriptLoader()
```

### 4.3 Définir ton entry

Tu choisis une entry, exemple `app` :

```js
.addEntry('app', './assets/entries/app.tsx')
```

Tu peux aussi avoir `admin`, `landing`, etc.

### 4.4 Créer l’entry React

`assets/entries/app.tsx` :

```tsx
import React from "react";
import { createRoot } from "react-dom/client";
import App from "../react/App";

const el = document.getElementById("main-app");

if (el) {
  const root = createRoot(el);
  root.render(<App />);
}
```

Note importante : on teste `if (el)` pour éviter les erreurs si la div n’existe pas sur certaines pages.

### 4.5 Créer l’App racine

`assets/react/App.tsx` :

```tsx
import React from "react";

export default function App() {
  return (
    <div>
      <h1>React dans Symfony</h1>
      <p>Symfony rend le Twig, React rend l'UI ici.</p>
    </div>
  );
}
```

### 4.6 Ajouter la div root dans Twig

Dans ton Twig (ex : `templates/home/index.html.twig`) :

```twig
{% extends 'base.html.twig' %}

{% block body %}
  <div id="main-app"></div>
{% endblock %}
```

### 4.7 Inclure les assets Encore dans le layout

Dans `base.html.twig` :

```twig
{% block stylesheets %}
  {{ encore_entry_link_tags('app') }}
{% endblock %}

{% block javascripts %}
  {{ encore_entry_script_tags('app') }}
{% endblock %}
```

### 4.8 Build et test

Dev :

```bash
npm run dev
```

Watch :

```bash
npm run watch
```

Prod :

```bash
npm run build
```

---

## 5) Le point clé : comment échanger des données entre Symfony et React ?

C’est souvent là que les projets deviennent confus. Voici 3 méthodes propres.

### Méthode 1 : “Props injectées depuis Twig” (simple, très efficace)

Symfony calcule des données, Twig les injecte, React les lit.

Exemple Twig :

```twig
<div
  id="main-app"
  data-user="{{ app.user ? app.user.userIdentifier : '' }}"
  data-locale="{{ app.request.locale }}"
></div>
```

Puis côté entry :

```tsx
const el = document.getElementById("main-app");

if (el) {
  const user = el.getAttribute("data-user") || "";
  const locale = el.getAttribute("data-locale") || "fr";

  createRoot(el).render(<App user={user} locale={locale} />);
}
```

Et dans `App.tsx` :

```tsx
export default function App({ user, locale }: { user: string; locale: string }) {
  return (
    <div>
      <p>User: {user}</p>
      <p>Locale: {locale}</p>
    </div>
  );
}
```

Avantages :

* ultra simple,
* pas d’API à écrire,
* parfait pour un widget ou une page.

Limite :

* dès que tu veux beaucoup de data ou du dynamique, ça devient moins pratique.

---

### Méthode 2 : “JSON injecté dans un script tag” (propre pour objets complexes)

Twig :

```twig
<script id="app-bootstrap" type="application/json">
  {{ {
    user: app.user ? app.user.userIdentifier : null,
    locale: app.request.locale,
    csrfToken: csrf_token('app')
  }|json_encode|raw }}
</script>

<div id="main-app"></div>
```

Entry :

```tsx
function readBootstrap() {
  const el = document.getElementById("app-bootstrap");
  if (!el) return {};
  try {
    return JSON.parse(el.textContent || "{}");
  } catch {
    return {};
  }
}

const bootstrap = readBootstrap();
createRoot(document.getElementById("main-app")!).render(<App bootstrap={bootstrap} />);
```

Avantages :

* gère des objets imbriqués,
* très lisible,
* centralise “l’état initial” envoyé par Symfony.

---

### Méthode 3 : Symfony comme API (fetch côté React)

Tu crées des routes JSON et React fait des `fetch()`.

Symfony Controller (exemple simple) :

* Route : `/api/products` renvoie du JSON.

React :

```tsx
useEffect(() => {
  fetch("/api/products")
    .then(r => r.json())
    .then(setProducts);
}, []);
```

Avantages :

* scalable,
* séparation claire,
* fonctionne très bien avec SPA.

Inconvénients :

* auth/CSRF/cookies/tokens à traiter correctement,
* plus de code.

---

## 6) Sécurité : CSRF, authentification, sessions

### 6.1 Si tu utilises la session Symfony (cookies)

Le navigateur envoie les cookies automatiquement sur le même domaine.
Donc un `fetch("/api/...")` fonctionne en restant “authentifié” si l’API est sur le même domaine.

Attention :

* si tu fais du cross-domain, tu entres dans CORS et c’est plus complexe (à éviter si possible).

### 6.2 CSRF pour les requêtes mutantes (POST/PUT/DELETE)

Si tu fais des formulaires via API, il faut un mécanisme.

Option classique :

* Symfony génère un token CSRF,
* tu l’injectes dans bootstrap JSON,
* React l’envoie dans un header (ou body) sur les requêtes.

Exemple header :

* `X-CSRF-TOKEN: ...`

Tu valides côté Symfony selon ta stratégie (ça dépend du type de contrôleur: formulaire classique, endpoint custom, etc.).

---

## 7) Routage : qui fait quoi ?

### 7.1 Routing Symfony uniquement (widget)

* Symfony garde les routes `/`, `/profile`, etc.
* Chaque page peut avoir ou non une racine React.

Très simple.

### 7.2 Routing React (SPA)

* Symfony sert une route “catch-all” (ex `/app/{reactRouting}`) qui rend le même Twig.
* React Router gère ensuite `/app/dashboard`, `/app/settings`, etc.

Côté Symfony :

* une route qui renvoie toujours le Twig, puis React route.

Points d’attention :

* si l’utilisateur recharge `/app/settings`, Symfony doit répondre avec le Twig (pas 404).
* en prod, attention aux règles serveur (nginx/apache) si tu fais du front séparé, mais ici Symfony répond donc c’est ok.

---

## 8) Organisation du code : conventions pratiques

### 8.1 Découpage conseillé (pour un TP)

* `assets/entries/app.tsx` : bootstrap (lecture data, mount React)
* `assets/react/App.tsx` : layout racine
* `assets/react/pages/` : pages
* `assets/react/components/` : composants
* `assets/react/services/api.ts` : fonctions fetch
* `assets/react/types/` : types TS

### 8.2 Exemple `api.ts` minimal

```ts
export async function apiGet<T>(url: string): Promise<T> {
  const res = await fetch(url, { headers: { "Accept": "application/json" }});
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}
```

---

## 9) Build dev vs prod : ce qui change vraiment

### 9.1 Dev

* bundles non minifiés
* erreurs lisibles
* rebuild rapides (watch)

### 9.2 Prod

* minification
* hash dans les noms (si versioning activé)
* perf et cache

Conseil :

* activer le versioning en prod (cache busting) :

```js
if (Encore.isProduction()) {
  Encore.enableVersioning();
}
```

---

## 10) Dépannage : problèmes fréquents

### 10.1 “React ne s’affiche pas”

Checklist :

* la div root existe-t-elle dans le Twig ? (`id="main-app"`)
* l’entry est-elle bien incluse dans `base.html.twig` ?
* `npm run dev` a-t-il généré `public/build/` ?
* console navigateur : erreur JS ?

### 10.2 “Cannot read properties of null (reading '...')”

Tu fais `document.getElementById('main-app')` mais la div n’existe pas sur cette page.
Solution : `if (el) { ... }`.

### 10.3 “JSX/TSX not supported”

Tu n’as pas activé :

* `.enableReactPreset()` pour JSX
* `.enableTypeScriptLoader()` pour TS/TSX

### 10.4 “tsconfig noEmit”

Selon les setups TS, `noEmit: true` peut casser le build.
Mettre `noEmit: false` si Encore/TS te le demande (cas vu dans certains contextes).

---

## 11) Conseils pédagogiques (si tu en fais un TP)

Progression simple en 1 journée :

1. Installer React + activer preset Encore.
2. Faire apparaître un composant simple dans Twig.
3. Créer 2-3 composants (liste, formulaire contrôlé).
4. Injecter une config depuis Twig (locale, user).
5. Bonus : fetch vers `/api/ping` ou `/api/items`.

Tu obtiens un TP complet : bundling, composantisation, cycle de build, intégration Symfony.

---

## 12) Récapitulatif (schéma)

```mermaid
flowchart TD
  A[Utilisateur] --> B[Route Symfony]
  B --> C[Controller]
  C --> D[Twig]
  D --> E[Div root
  E --> F[Assets Encore: app.js/app.tsx]
  F --> G[createRoot + render(App)]
  G --> H[Composants React affichés]
  H --> I[Optionnel: fetch /api/... vers Symfony]
```

---

## Conclusion

React dans Symfony via Webpack Encore est une approche très saine quand :

* tu veux garder Symfony comme base solide (routing, sécurité, backend),
* tu veux une UI moderne (React),
* tu veux éviter de séparer en deux projets.

La clé de la réussite, c’est :

* un choix d’architecture (widget vs SPA),
* une stratégie claire de transfert de données (props, bootstrap JSON, API),
* une organisation de code cohérente.
