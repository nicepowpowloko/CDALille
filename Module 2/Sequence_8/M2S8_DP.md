<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Déroulé pédagogique – Consommation d’une API REST en JavaScript (1 jour)**

## **Objectif global**

Comprendre le fonctionnement d’une API REST, savoir interroger une ressource distante avec `fetch()`, manipuler les données JSON retournées par l’API, les afficher dynamiquement dans une interface HTML, et mettre en place des filtres client (search + région).

---

## **Contenus de la journée**

### **1 – Comprendre une API REST (bases CDA)**

* Définition d’une API REST : ressources, URLs, verbes HTTP, stateless 
* Structure et rôle du JSON dans les échanges
* Codes HTTP essentiels : 200, 201, 400, 401, 404, 500
* Exemple d’architecture REST (client → API → base de données)

---

### **2 – Consommer une API avec JavaScript**

* Principe de `fetch()`
* Vérification des erreurs (`response.ok`, `throw new Error`)
* Conversion des réponses : `response.json()`
* Étude de cas : API REST Countries (structure retournée, champs utiles) 

---

### **3 – Manipulation du JSON retourné**

* Parcours d’un tableau d’objets
* Extraction : nom, capitale, population, drapeau…
* Méthodes essentielles : `map`, `filter`, `find`
* Gestion des valeurs manquantes (opérateur `??`, optional chaining)

---

### **4 – Construction d’une interface dynamique**

* Injection HTML via JavaScript (`createElement`, `innerHTML`)
* Affichage d’une liste de pays sous forme de cartes
* Mise en page simple (grid CSS)

---

### **5 – Mise en place des filtres**

* Recherche par nom (événement `input`)
* Filtrage par région (événement `change`)
* Combiner plusieurs filtres successifs (search + region)

---

## **Activités pédagogiques**

### **Exercice 1 – Premier appel API**

Interroger `https://restcountries.com/v3.1/all` et afficher les données reçues dans la console.

### **Exercice 2 – Analyse du JSON**

Comprendre et manipuler les propriétés `name`, `capital`, `population`, `flags`, `region`.

### **Exercice 3 – Affichage dynamique**

Créer des cartes HTML pour afficher les pays (nom, capitale, population, drapeau).

### **Exercice 4 – Recherche par nom**

Mettre en place un champ de recherche filtrant les résultats en direct.

### **Exercice 5 – Filtre par région**

Ajouter une liste déroulante permettant de filtrer les pays selon leur région.

### **Mini-projet – “Explorateur de Pays”**

Construire une application complète permettant :

* appel API
* affichage dynamique
* recherche + filtrage par région
* affichage automatique du JSON formaté en console pour diagnostic

**Objectif du jour :** être capable de consommer une API REST, d’exploiter un JSON retourné, et de construire une interface dynamique simple en JavaScript.
