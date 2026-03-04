# TP - Symfony + CRUD + îlot React avec Vite

## Contexte

On réalise une application Symfony minimaliste avec une entité `Product`. On génère un CRUD pour gérer les produits. Sur la page de détail d’un produit, on affiche un composant React (îlot React) permettant d’envoyer un prompt à une route Symfony et d’afficher la réponse.

L’îlot React est construit avec Vite et intégré dans Twig.

## Objectifs pédagogiques

A la fin du TP, on sait:

- créer un projet Symfony et une entité Doctrine

- générer un CRUD avec MakerBundle

- intégrer Vite dans Symfony (dev server + inclusion Twig)

- monter un composant React sur un élément HTML rendu par Twig (approche “islands”)

- appeler une route Symfony en fetch POST JSON et afficher la réponse

## Prérequis

- PHP 8.2+ (ou version compatible avec le projet)

- Composer

- Node.js + npm

- Un SGBD configuré (SQLite possible pour aller vite, ou MariaDB/MySQL)

- Symfony CLI (facultatif mais pratique)

## Livrables attendus

- Une page `/product/` (liste CRUD)

- Une page `/product/{id}` (show CRUD) affichant un bloc React “Prompt IA”

- Le bloc React envoie un prompt vers `/ai/prompt` et affiche une réponse JSON

---

# Partie A - Projet Symfony + entité + CRUD

## A1. Créer le projet

```bash
symfony new tp-vite-react --webapp
cd tp-vite-react
```

### Checkpoint A1

- On peut lancer le serveur Symfony:

```bash
symfony serve
```

- On accède à la page d’accueil Symfony sans erreur.

## A2. Configurer la base de données

On choisit:

- SQLite (le plus simple)

- ou MariaDB/MySQL si on veut travailler comme en entreprise

Avec SQLite, on peut mettre dans `.env`:

```env
DATABASE_URL="sqlite:///%kernel.project_dir%/var/data.db"
```

### Checkpoint A2

- La commande suivante ne doit pas échouer:

```bash
php bin/console doctrine:database:create
```

(Si SQLite, cette commande peut être inutile, c’est normal.)

## A3. Créer l’entité Product

```bash
composer require symfony/maker-bundle --dev
php bin/console make:entity Product
```

Champs recommandés:

- `name` : string(255)

- `price` : integer (on stocke en centimes)

Puis:

```bash
php bin/console make:migration
php bin/console doctrine:migrations:migrate
```

### Checkpoint A3

- La table `product` existe dans la base.

- Pas d’erreur de migration.

## A4. Générer le CRUD

```bash
php bin/console make:crud Product
```

### Checkpoint A4

- On accède à `/product/`

- On peut créer un produit, puis le voir, le modifier, le supprimer

---

# Partie B - Intégration Vite + React

## B1. Installer le bundle Symfony côté PHP

```bash
composer require pentatrion/vite-bundle
```

### Checkpoint B1

- `composer` termine sans erreur

- Un fichier de config lié au bundle apparaît (selon recettes Symfony)

## B2. Initialiser le front avec Vite

A la racine du projet:

```bash
npm init -y
npm i
npm i -D vite @vitejs/plugin-react vite-plugin-symfony
npm i react react-dom
```

### Checkpoint B2

- `node_modules/` est créé

- `npm` n’affiche pas d’erreur bloquante

## B3. Créer les fichiers front

### Arborescence

On crée:

- `assets/app.jsx`

- `assets/react/PromptBox.jsx`

- `vite.config.js`

### Fichier `vite.config.js`

```js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import symfony from "vite-plugin-symfony";

export default defineConfig({
  plugins: [
    react(),
    symfony({
      input: {
        app: "./assets/app.jsx",
      },
    }),
  ],
});
```

Si on a une erreur “input/inputs”, on adapte selon le message affiché (certaines versions attendent `inputs`).

### Fichier `assets/app.jsx`

```jsx
import React from "react";
import { createRoot } from "react-dom/client";
import PromptBox from "./react/PromptBox.jsx";

const registry = { PromptBox };

document.querySelectorAll(".react-island").forEach((el) => {
  const name = el.dataset.component;
  const props = JSON.parse(el.dataset.props || "{}");
  const Component = registry[name];
  if (!Component) return;

  createRoot(el).render(<Component {...props} />);
});
```

### Fichier `assets/react/PromptBox.jsx`

```jsx
import React, { useState } from "react";

export default function PromptBox({ endpoint }) {
  const [prompt, setPrompt] = useState("");
  const [answer, setAnswer] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  async function send() {
    setLoading(true);
    setError("");
    setAnswer("");

    try {
      const res = await fetch(endpoint, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ prompt }),
      });

      const data = await res.json().catch(() => ({}));
      if (!res.ok) throw new Error(data.error ?? `HTTP ${res.status}`);

      setAnswer(data.answer ?? "");
    } catch (e) {
      setError(e.message || "Erreur inconnue");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div style={{ border: "1px solid #ddd", padding: 12, borderRadius: 8 }}>
      <p style={{ marginTop: 0 }}>Prompt IA (îlot React)</p>

      <textarea
        value={prompt}
        onChange={(e) => setPrompt(e.target.value)}
        rows={4}
        style={{ width: "100%", boxSizing: "border-box" }}
      />

      <div style={{ marginTop: 8 }}>
        <button onClick={send} disabled={loading || prompt.trim() === ""}>
          {loading ? "Envoi..." : "Envoyer"}
        </button>
      </div>

      {error && <p style={{ color: "crimson" }}>{error}</p>}
      {answer && <pre style={{ whiteSpace: "pre-wrap" }}>{answer}</pre>}
    </div>
  );
}
```

### Checkpoint B3

- Les 3 fichiers existent

- Il n’y a pas d’erreur de syntaxe évidente

---

# Partie C - Inclure Vite dans Twig

## C1. Ajouter les tags Vite dans `base.html.twig`

Dans `templates/base.html.twig`, on ajoute (souvent dans le `<head>` pour les CSS et avant `</body>` pour les scripts, mais on peut tout mettre au même endroit pour le TP):

```twig
{{ vite_entry_link_tags('app') }}
{{ vite_entry_script_tags('app') }}
```

### Checkpoint C1

- Symfony ne plante pas sur une erreur Twig “fonction inconnue”
  
  - Si c’est le cas, vérifier que `pentatrion/vite-bundle` est bien installé et activé

---

# Partie D - Route Symfony pour le prompt + insertion de l’îlot React

## D1. Créer la route `/ai/prompt`

Créer `src/Controller/AiController.php`:

```php
<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Attribute\Route;

final class AiController extends AbstractController
{
    #[Route('/ai/prompt', name: 'ai_prompt', methods: ['POST'])]
    public function prompt(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true) ?? [];
        $prompt = trim((string) ($data['prompt'] ?? ''));

        if ($prompt === '') {
            return $this->json(['error' => 'Prompt vide'], 400);
        }

        // Réponse simulée pour le TP
        $answer = "Réponse IA simulée:\n" . $prompt;

        return $this->json(['answer' => $answer]);
    }
}
```

### Checkpoint D1

- Un POST vers `/ai/prompt` renvoie du JSON

- On peut tester vite fait:

```bash
curl -X POST http://127.0.0.1:8000/ai/prompt \
  -H "Content-Type: application/json" \
  -d '{"prompt":"Bonjour"}'
```

## D2. Ajouter l’îlot React dans la page show du CRUD

Dans `templates/product/show.html.twig`, on insère:

```twig
<div
  class="react-island"
  data-component="PromptBox"
  data-props='{{ { endpoint: path("ai_prompt") }|json_encode|e("html_attr") }}'
></div>
```

### Checkpoint D2

- La page `/product/{id}` affiche le bloc React

- On tape un prompt, on clique “Envoyer”, la réponse simulée s’affiche

---

# Partie E - Lancer le projet en mode dev

On lance Symfony:

```bash
symfony serve
```

On lance Vite dans un second terminal:

```bash
npx vite
```

### Checkpoint final

- On ouvre `/product/`

- On clique sur un produit

- Le composant React apparaît

- Le fetch fonctionne (pas d’erreur CORS, pas de 404, pas de 500)

---

# Erreurs fréquentes et dépannage

## 1) Le bloc React n’apparaît pas

Causes possibles:

- Vite n’est pas lancé

- Les tags Vite ne sont pas inclus dans Twig

- Le sélecteur `.react-island` ne trouve rien (mauvaise classe)

- Le composant n’est pas dans `registry` ou mauvais `data-component`

Test rapide:

- Ouvrir la console navigateur, chercher des erreurs JS

- Vérifier que le HTML contient bien le `<div class="react-island" ...>`

## 2) Erreur 404 sur `/ai/prompt`

- La route n’existe pas ou mauvais `name`

- La méthode n’est pas POST

- Le `path("ai_prompt")` ne correspond pas

Test:

- `php bin/console debug:router | grep ai_prompt`

## 3) Erreur “Invalid JSON”

- Le fetch envoie autre chose que du JSON

- `Content-Type` manquant

- `json_decode` reçoit du vide

Test:

- Inspecter la requête dans l’onglet Réseau du navigateur

## 4) Problème “input/inputs” dans Vite

- Certaines versions attendent une option différente

- Lire l’erreur, adapter `vite.config.js` (souvent `inputs` au lieu de `input`)

---

# Extensions (optionnelles)

## Extension 1 - Préremplir le prompt avec le produit affiché

Dans `show.html.twig`, on peut passer le nom du produit au composant:

```twig
data-props='{{ {
  endpoint: path("ai_prompt"),
  defaultPrompt: "Décris ce produit: " ~ product.name
}|json_encode|e("html_attr") }}'
```

Puis dans React, on initialise `prompt` avec `defaultPrompt`.

## Extension 2 - Sécuriser la route

- Réserver `/ai/prompt` aux utilisateurs connectés

- Ajouter une limite de taille sur le prompt

- Ajouter un rate limiter

## Extension 3 - Remplacer l’IA simulée

- On remplace la réponse simulée par un service qui appelle un LLM (OpenAI, Ollama, etc.)

- React ne change pas, seule la route / le service change


