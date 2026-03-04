
<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Référence : Toutes les façons d’utiliser un fichier JSON (Front-end, Node.js, PHP)**

Ce document montre **tous les moyens pratiques** de charger ou d’utiliser un fichier JSON selon le contexte.  

Il utilise partout le fichier suivant :

## **Exemple de fichier JSON : `./data/elrond.json`**

```json
{
  "nom": "Elrond",
  "race": "Elfe",
  "habitat": "Fondcombe",
  "compagnons": [
    { "nom": "Glorfindel", "role": "Guerrier" },
    { "nom": "Erestor", "role": "Conseiller" }
  ]
}
```

---

## **1. En JavaScript côté navigateur (Front-end)**

---

### **1.1. Charger un JSON avec `fetch()` (méthode standard)**

Cette méthode fonctionne partout et doit être considérée comme **la référence**.

```js
fetch("./data/elrond.json")
  .then(res => res.json())
  .then(data => {
    console.log(data.nom);   // Elrond
    console.log(data.race);  // Elfe
  });
```

Ou en version moderne :

```js
async function chargerPersonnage() {
  const res = await fetch("./data/elrond.json");
  const personnage = await res.json();
  console.log(personnage.habitat); // Fondcombe
}

chargerPersonnage();
```

 Fonctionne sur tous navigateurs  

 Idéal pour des fichiers locaux ou des API  

!!! Nécessite un serveur web (ne fonctionne pas en ouvrant un fichier HTML directement) !!!

---

### **1.2. Importer un JSON comme module ES (fonctionnalité expérimentale)**

Certaines versions modernes de Chrome, Edge, Firefox ou Safari permettent :

#### **Import statique**

```js
import elrond from "./data/elrond.json" with { type: "json" };

console.log(elrond.nom); // Elrond
```

#### **Import dynamique**

```js
const module = await import("./data/elrond.json", {
  with: { type: "json" }
});

console.log(module.default.race); // Elfe
```

 Très élégant (est-ce vraiment un critère ???)  

!!! Fonctionnalité encore jeune, pas supportée partout !!!

---

### **1.3. Stocker du JSON directement dans HTML**

Vous pouvez intégrer vos données directement dans la page HTML :

#### **HTML**

```html
<script id="elrond-data" type="application/json">
{
  "nom": "Elrond",
  "race": "Elfe",
  "habitat": "Fondcombe"
}
</script>
```

#### **JavaScript**

```js
const contenu = document.getElementById("elrond-data").textContent;
const data = JSON.parse(contenu);

console.log(data.nom); // Elrond
```

 Fonctionne sans serveur  

 Compatible partout  

!!! Idéal surtout pour de petites données statiques !!!

---

### **1.4. Charger le JSON via `<script>` (en transformant le JSON en JS)**

Un fichier JSON **ne peut pas être chargé directement** avec `<script src="">`.

Cependant, on peut transformer le JSON en **module JavaScript** :

#### **data-elrond.js**

```js
export default {
  nom: "Elrond",
  race: "Elfe",
  habitat: "Fondcombe",
  compagnons: [
    { nom: "Glorfindel", role: "Guerrier" },
    { nom: "Erestor", role: "Conseiller" }
  ]
};
```

#### **HTML**

```html
<script type="module">
  import elrond from "./data-elrond.js";
  console.log(elrond.nom); // Elrond
</script>
```

 Fonctionne partout où les modules ES sont supportés  

!!! Ce n’est **plus un fichier JSON**, mais du JavaScript !!!

---

## **2. En Node.js (Back-end JavaScript)**

---

### **2.1. Import moderne avec `assert { type: "json" }`**

```js
import elrond from "./data/elrond.json" assert { type: "json" };

console.log(elrond.race); // Elfe
```

 Méthode moderne

!!! Nécessite Node.js V 18 et plus !!!

---

### **2.2. Ancienne méthode : `require()`**

```js
const elrond = require("./data/elrond.json");

console.log(elrond.nom); // Elrond
```

 Simple  

!!! Utilisable uniquement si votre projet est en **CommonJS** (sans `type="module"`) !!!

---

### **2.3. Lecture manuelle avec `fs`**

```js
import { readFile } from "fs/promises";

const texte = await readFile("./data/elrond.json", "utf8");
const data = JSON.parse(texte);

console.log(data.habitat); // Fondcombe
```

 Universel  

 Parfait pour des fichiers volumineux

---

## **3. Avec PHP (Back-end Web)**

PHP est souvent utilisé pour lire un JSON, le modifier, ou le renvoyer à une page web.

---

### **3.1. Lire un fichier JSON local en PHP**

```php
<?php
$json = file_get_contents("./data/elrond.json");
$data = json_decode($json, true);

echo $data["nom"]; // Elrond
```

 Simple  

 Lecture locale efficace

---

### **3.2. Lire un JSON provenant d’une API externe**

```php
<?php
$url = "https://api.example.com/elrond";
$json = file_get_contents($url);
$data = json_decode($json, true);

echo $data["race"];
```

 Méthode rapide  

!!! Peut nécessiter `allow_url_fopen` activé !!!

---

### **3.3. PHP renvoie du JSON à une page web (endpoint)**

#### **get-elrond.php**

```php
<?php
header("Content-Type: application/json; charset=utf-8");

$json = file_get_contents("./data/elrond.json");
$data = json_decode($json, true);

$data["source"] = "Serveur PHP";

echo json_encode($data);
```

#### **JavaScript qui consomme ce PHP**

```js
const res = await fetch("./get-elrond.php");
const elrond = await res.json();

console.log(elrond.source); // Serveur PHP
```

 C’est la base d’une API back-end  

---

### **3.4. Générer un JSON en PHP sans fichier**

```php
<?php
header("Content-Type: application/json");

$elrond = [
  "nom" => "Elrond",
  "race" => "Elfe",
  "habitat" => "Fondcombe",
];

echo json_encode($elrond);
```

 Utile pour créer des API  

 Simple et puissant

---

## **4. Tableau récapitulatif final**

| Contexte       | Méthode                            | Exemple                           | Points forts                   | Limites                 |
| -------------- | ---------------------------------- | --------------------------------- | ------------------------------ | ----------------------- |
| **Navigateur** | `fetch()`                          | `fetch("./elrond.json")`          | Standard, universel            | Nécessite un serveur    |
| Navigateur     | Import JSON (expérimental)         | `import ... with {type:"json"}`   | Très propre                    | Support partiel         |
| Navigateur     | `<script type="application/json">` | JSON dans le HTML                 | Parfait pour données statiques | Pas de fichier externe  |
| Navigateur     | Module JS exportant un objet       | `import elrond from "./data.js"`  | Compatible partout             | Ce n’est plus du JSON   |
| **Node.js**    | Import moderne                     | `import ... assert {type:"json"}` | Lecture native du JSON         | Node 18+                |
| Node.js        | `require()`                        | `require("./elrond.json")`        | Très simple                    | CJS uniquement          |
| Node.js        | fs + JSON.parse                    | `readFile(...);`                  | Contrôle total                 | Plus de code            |
| **PHP**        | Lire fichier local                 | `file_get_contents()`             | Simple, efficace               | Fichier doit exister    |
| PHP            | Lire JSON externe                  | `file_get_contents($url)`         | Facile                         | Peut nécessiter config  |
| PHP            | PHP → JSON (API)                   | `echo json_encode()`              | Parfait pour API               | Nécessite un serveur    |
| PHP + JS       | JS fetch PHP                       | `fetch("./get-elrond.php")`       | Full stack complet             | Structure API à prévoir |
