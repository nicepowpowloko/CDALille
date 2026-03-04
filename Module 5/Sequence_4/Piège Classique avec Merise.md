<img src="../../Logo.png" width="550" height="75" alt="logo">


# Piège classique - Confondre table SQL et entité Merise

## Le piège

Lorsqu’on passe du **MCD (conceptuel)** au **MLD / MPD (logique ou physique)**, on observe que certaines **associations deviennent des tables** en base de données.

Beaucoup en déduisent à tort que :

> *« Si c’est une table, alors c’est une entité. »*

**C’est faux.**

---

## Pourquoi la confusion est fréquente

* En SQL, **tout est une table**
* Une association porteuse d’attributs (ex : NOTE, LIGNE_COMMANDE, ENSEIGNEMENT)
  devient techniquement une table
* Les outils (SGBD, ORM, frameworks) **masquent le raisonnement conceptuel**

On confond alors **implémentation technique** et **modélisation métier**.

---

## La règle Merise à retenir

> **Une entité existe par elle-même.
> Une association n’existe que par le lien entre entités.**

Pose toujours la question :

> *« Ce concept a-t-il un sens si je supprime les entités auxquelles il est relié ? »*

* **Oui** → entité
* **Non** → association

---

## Exemples typiques

| Concept           | Nature      | Pourquoi                              |
| ----------------- | ----------- | ------------------------------------- |
| Élève             | Entité      | Existe indépendamment                 |
| Matière           | Entité      | Existe indépendamment                 |
| Classe            | Entité      | Existe indépendamment                 |
| Note              | Association | N’existe qu’entre élève et matière    |
| Enseignement      | Association | N’existe qu’entre classe et matière   |
| Ligne de commande | Association | N’existe qu’entre commande et article |

---

## À ne pas oublier

> **Une association peut devenir une table,
> mais une table n’est pas forcément une entité.**

---

## En résumé

* Le **MCD** sert à comprendre le métier
* Le **SQL** sert à stocker les données
* On ne raisonne **pas en table** au niveau conceptuel
* Merise privilégie le **sens**, pas la technique

