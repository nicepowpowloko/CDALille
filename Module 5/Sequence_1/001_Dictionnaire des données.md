<img src="../../Logo.png" width="550" height="75" alt="logo">


# Le dictionnaire des données

**Domaine** : Développement web  
**Contexte** : Application e-commerce  
**Objectif** : Identifier et structurer les données nécessaires à la persistance des informations

---

## Sommaire

I. Analyse de l'existant  
II. Exemple de documents métiers  
III. Règles de gestion  
IV. Dictionnaire des données  

---

## I. Analyse de l'existant

La première étape dans la conception d'une base de données consiste à identifier et analyser l'ensemble des documents et supports représentant les données à gérer par l'application.

Dans le cadre d'un site e-commerce, ces sources peuvent être :

- des bases de données existantes (ancien site, outil de gestion interne) ;
- des documents fonctionnels (catalogue produits, bons de commande, factures) ;
- des échanges avec les utilisateurs métiers (gestionnaire de catalogue, service client, logistique).

Cette phase permet de comprendre quelles informations doivent être stockées, mises à jour et exploitées par le système.

---

## II. Exemple de documents métiers

Pour illustrer le propos, on considère un site e-commerce permettant à des clients de commander des produits en ligne.

### Liste des clients

| N° client | Nom | Prénom | Email | Date d'inscription |
|----------:|-----|--------|-------|--------------------|
| 1001 | MARTIN | Paul | paul.martin@mail.com | 12/03/2024 |
| 1002 | MIMOUNI | Nissa | nissa.mimouni@mail.com | 25/04/2024 |
| 1003 | DURAND | Michel | michel.durand@mail.com | 02/05/2024 |
| ... | ... | ... | ... | ... |

### Catalogue des produits

| Réf. produit | Nom du produit | Prix HT | Stock |
|--------------|----------------|---------:|------:|
| P001 | Clavier mécanique | 89.90 | 42 |
| P002 | Souris sans fil | 29.90 | 120 |
| P003 | Écran 27 pouces | 249.00 | 18 |
| ... | ... | ... | ... |

### Détail d'une commande

**Commande n°** : 50012  
**Client** : Paul MARTIN  
**Date** : 10/06/2024  

| Réf. produit | Nom du produit | Quantité | Prix unitaire |
|--------------|----------------|----------:|---------------:|
| P001 | Clavier mécanique | 1 | 89.90 |
| P002 | Souris sans fil | 2 | 29.90 |

---

## III. Règles de gestion

- Un client peut passer plusieurs commandes.
- Une commande est associée à un seul client.
- Une commande contient au moins un produit.
- Un produit peut apparaître dans plusieurs commandes.
- Le stock d’un produit ne peut pas être négatif.
- Le prix d’un produit est strictement positif.

---

## IV. Dictionnaire des données

À partir des documents analysés, on extrait les informations élémentaires (non décomposables) destinées à être stockées dans la base de données.

L'ensemble de ces informations, appelées **attributs** ou **champs**, constitue le dictionnaire des données.

Chaque attribut est décrit à l’aide des propriétés suivantes.

### Propriétés d'un attribut

| Propriété | Signification |
|----------|---------------|
| **Code** | Nom technique de l'attribut, respectant les conventions de nommage (explicite, lisible, sans abréviations ambiguës). |
| **Libellé** | Description fonctionnelle claire de l'attribut. |
| **Type de donnée** | Type de l'information stockée : entier, réel, chaîne de caractères, date, booléen, etc. |
| **Contraintes d'intégrité** | Règles limitant les valeurs possibles (unicité, bornes, valeurs autorisées). |
| **Règle de calcul** | Mode de calcul de l'attribut, si sa valeur est dérivée d'autres données. |

---

## Dictionnaire des données (extrait)

| Code | Libellé | Type | Contraintes | Règle de calcul |
|------|--------|------|-------------|----------------|
| idClient | Identifiant du client | Entier | > 0, unique | |
| nomClient | Nom du client | Chaîne(50) | Non nul | |
| prenomClient | Prénom du client | Chaîne(50) | Non nul | |
| emailClient | Adresse email | Chaîne(100) | Unique, format email | |
| dateInscription | Date d'inscription | Date | | |
| idProduit | Identifiant du produit | Entier | > 0, unique | |
| nomProduit | Nom du produit | Chaîne(100) | Non nul | |
| prixHT | Prix hors taxes | Décimal(8,2) | > 0 | |
| stockProduit | Quantité en stock | Entier | ≥ 0 | |
| idCommande | Identifiant de la commande | Entier | > 0, unique | |
| dateCommande | Date de la commande | Date | | |
| quantite | Quantité commandée | Entier | > 0 | |
| totalCommande | Montant total de la commande | Décimal(10,2) | ≥ 0 | Somme des lignes de commande |

---

*Document de référence – Dictionnaire des données*  
*Contexte : application e-commerce*

