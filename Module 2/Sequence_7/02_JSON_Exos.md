<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Exercices JSON en JavaScript (Ash nazg durbatulûk ...)**

## Objectifs

Comprendre JSON.parse, JSON.stringify, filtrer un tableau, transformer les données et préparer l’utilisation d’une API REST.

---

## **Exercice 1 – JSON.parse**

On vous donne cette chaîne JSON :

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

Faire :

1. parser la chaîne
2. afficher la race
3. afficher le nom du premier compagnon
4. afficher le rôle du second compagnon

---

## **Exercice 2 – JSON.stringify**

Créer un objet représentant un hobbit :

```js
{
  nom: "Meriadoc",
  race: "Hobbit",
  specialite: "Herboriste"
}
```

1. convertir en JSON
2. afficher la chaîne obtenue
3. vérifier que son type est `"string"`

---

## **Exercice 3 – Manipuler un tableau JSON**

Voici un tableau JSON :

```json
[
  { "nom": "Gimli", "race": "Nain" },
  { "nom": "Legolas", "race": "Elfe" },
  { "nom": "Uglúk", "race": "Uruk-hai" },
  { "nom": "Frodo", "race": "Hobbit" },
  { "nom": "Théoden", "race": "Humain" }
]
```

Après `JSON.parse`, faire :

1. afficher tous les noms
2. récupérer uniquement les elfes
3. créer un tableau contenant seulement les races
4. trouver l’objet correspondant à `"Frodo"`
5. afficher les noms se terminant par `"a"` ou `"o"`

---

## **Exercice 4 – Filtrage avancé**

Écrire une fonction :

```js
function filtrerParRace(personnages, raceRecherchee) { ... }
```

Tester avec `"Nain"`, `"Elfe"`, `"Uruk-hai"`.

---

## **Exercice 5 – Transformation (map)**

Écrire une fonction :

```js
function presenter(p) {
  return `${p.nom} appartient à la race ${p.race}.`;
}
```

Utiliser `.map()` pour créer un tableau de phrases à partir du tableau parsé.

---

## **Exercice 6 – Du JSON vers des classes**

On suppose que vous avez les classes :
`Elfe`, `Nain`, `Hobbit`, `Orque`, `Humain`, `UrukHai`, et une classe générique `Personnage`.

Écrire :

```js
function creerInstanceDepuisJSON(obj) { ... }
```

qui retourne la bonne instance selon `obj.race`.

Ensuite :

1. parser un tableau JSON
2. transformer chaque objet en instance
3. appeler une méthode `agir()` sur chaque instance

---

## **Exercice 7 – Préparation API REST**

Écrire :

```js
function afficherNomsDepuisAPI(json) {
  // json est un tableau d'objets déjà parsé
}
```

Elle doit :

1. parcourir le tableau
2. afficher chaque nom

Cet exercice prépare la manipulation de `response.json()` dans le TP REST Countries.
