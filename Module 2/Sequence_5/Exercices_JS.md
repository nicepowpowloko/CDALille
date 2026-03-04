<img src="../../Logo.png" width="550" height="75" alt="logo">

# Exercices JavaScript

## Jour 1  Logique, structures et manipulation avancée

### Exercice 1  Validation de données

Demandez à l’utilisateur un nom, un âge et une adresse. Vérifiez :

* que le nom contient au moins 2 caractères
* que l’âge est un nombre valide
* que l’adresse contient au moins un numéro et un nom de rue

Affichez un résumé formaté.

---

### Exercice 2  Tableaux complexes

À partir d’un tableau d’objets représentant des produits (nom, prix, catégorie, stock) :

1. filtrez par catégorie
2. retournez seulement les produits en stock
3. calculez le total HT et TTC (TVA 20%)
4. triez les produits par prix croissant
5. générez un tableau contenant uniquement les noms en majuscule

---

### Exercice 3  Fonctions avancées

Créez :

* une fonction qui normalise une chaîne (trim, suppression double espaces)
* une fonction qui capitalise la première lettre d’un mot
* une fonction qui formate une phrase entière en utilisant les deux précédentes

---

### Exercice 4  Objets et méthodes

Créez un objet `bibliotheque` contenant :

* une liste de livres (titre, auteur, pages, lu)
* une méthode pour ajouter un livre
* une méthode pour marquer un livre comme lu selon son titre
* une méthode pour lister les livres non lus

Manipulez l’objet et affichez le résultat.

---

### Mini-projet  Gestionnaire de données JSON

Créez un petit script permettant :

* d’enregistrer une liste de données dans une chaîne JSON
* d’en extraire les données
* de modifier une entrée
* de réexporter le tout au format JSON formaté

---

## Jour 2  DOM avancé, composants et interactions complexes

### Exercice 5  Manipulation du DOM

Dans une page HTML :

* remplacez des éléments par de nouveaux via `replaceWith()`
* dupliquez une structure HTML avec `cloneNode(true)`
* ajoutez une bannière en haut de page contenant un message

---

### Exercice 6  Composant “carte” généré par JS

Créez une fonction `creerCarte(titre, contenu)` générant :

* un conteneur
* un titre
* un paragraphe
* un bouton « fermer » qui supprime la carte

Affichez plusieurs cartes dans la page.

---

### Exercice 7  Événements avancés

Réalisez une liste interactive :

* les éléments changent de couleur au clic
* un double-clic supprime l’élément
* le clic droit ouvre un mini-menu contextuel personnalisé

Toutes les actions sont gérées par **délégation**.

---

### Exercice 8  Formulaire dynamique avec champs multiples

Créez un formulaire permettant d’ajouter plusieurs « lignes » dynamiques (ex : compétences, tags, ingrédients, etc.) :

* un bouton « ajouter un champ » ajoute une ligne
* un bouton « x » supprime une ligne
* un résumé s’affiche sous le formulaire

---

### Mini-projet  Mini interface type “tableur”

Construisez un tableau éditable :

* chaque cellule devient éditable au clic
* validation par Entrée
* Échap annule les modifications
* ajout de lignes et de colonnes

Aucune librairie autorisée.

---

## Jour 3  Modules, architecture front et asynchronisme interne

### Exercice 9  Découpage en modules

Créez une application composée de :

* `utils.js` (fonctions utiles)
* `dom.js` (opérations DOM)
* `state.js` (gestion des données locales)
* `main.js` (initialisation)

`main.js` importe et utilise tous les modules.

---

### Exercice 10  Système d’événements personnalisés

Créez un système interne d’événements :

* un module peut déclencher un événement personnalisé (ex : `"donneesModifiees"`)
* un autre module peut s’y abonner via `addEventListener`
* un troisième module met à jour le DOM quand l’événement est capté

Sans API.

---

### Exercice 11  Simuler de l’asynchronisme sans API

Simulez un chargement de données avec :

* `setTimeout`
* une promesse qui se résout ou se rejette aléatoirement
* un loader dans le DOM
* un message d’erreur affiché dans le DOM en cas d’échec

---

### Exercice 12  Manipulation avancée des promesses

Créez :

* trois promesses simulant des tâches (1 à 3 secondes)
* un affichage du premier résultat reçu (`Promise.race`)
* un affichage une fois que toutes les tâches sont terminées (`Promise.all`)

---

### Mini-projet  Application modulaire complète (sans API)

Réalisez :

* un module `state.js` stockant une liste d’éléments (ex : tâches, notes, contacts)
* un module `ui.js` affichant et mettant à jour les éléments
* un module `logic.js` contenant les traitements (tri, filtrage, recherche)
* un module `main.js` orchestrant l’ensemble

Fonctionnalités :

* ajouter un élément
* supprimer
* trier (A→Z, Z→A)
* filtrer selon un critère
* persister dans `localStorage`
