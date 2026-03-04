<img src="../../Logo.png" width="550" height="75" alt="logo">


# Projet Cassandre – Dictionnaire des données

---

## Objectif du travail

L’objectif de ce travail est de **définir le dictionnaire des données** du projet *Cassandre* à partir du cahier des charges.

Il ne s’agit pas de coder, ni de produire des diagrammes UML ou Merise,  
mais de **décrire précisément les données que l’application doit stocker**.

---

## Principe

À partir du cahier des charges :

- identifier les **entités nécessaires** au projet,
- lister les **champs de chaque entité**,
- préciser le **type des données** et leur rôle.

Ce travail constitue la base de :
- la BDD,
- les entités Doctrine,
- les formulaires Symfony,
- la validation des données.

---

## Organisation du travail

Dans votre projet Symfony **Cassandre**, créer le répertoire suivant s’il n’existe pas :

```text
/conception
````

Dans ce répertoire, créer le fichier :

```text
DICTIONNAIRE_DONNEES.md
```

---

## Contenu attendu du dictionnaire des données

Le fichier `DICTIONNAIRE_DONNEES.md` doit contenir, pour **chaque entité**, un tableau décrivant ses champs.

### Format attendu


 Entité : NomDeLEntite

| Champ | Type | Obligatoire | Description |
|-------|------|-------------|-------------|
| ...   | ...  | ...         | ...         |


---

## Exemple

### Entité : Client

| Champ      | Type        | Obligatoire | Description              |
| ---------- | ----------- | ----------- | ------------------------ |
| id         | int         | oui         | Identifiant unique       |
| name       | string(100) | oui         | Nom du client            |
| email      | string(100) | oui         | Email de contact         |
| type       | string(50)  | oui         | entreprise / particulier |
| created_at | datetime    | oui         | Date de création         |

---

## Règles à respecter

* Les champs doivent être **simples et atomiques** (une information par champ).
* Les types doivent être **réalistes** par rapport à une base de données.
* Le dictionnaire doit être **cohérent avec le cahier des charges**.
* La perfection n’est pas attendue, la **logique et la clarté** oui.

---

## Résultat attendu

À la fin du travail :

* le fichier `DICTIONNAIRE_DONNEES.md` est présent dans `/conception`,
* toutes les entités du projet sont décrites,
* les données sont clairement identifiées avant toute implémentation.
