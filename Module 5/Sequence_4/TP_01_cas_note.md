<img src="../../Logo.png" width="550" height="75" alt="logo">


# TP 01 Cas Note

---

## Objectif

Dans le but de construire une base de données, la conception du modèle entité-association, suivie du modèle logique de données, constitue une étape intermédiaire entre :

- la récolte des informations constituant le dictionnaire de données ;
- le modèle physique de données propre à un SGBD propriétaire.

---

## But de la réalisation

Réaliser un modèle entité-association  
(modèle conceptuel de données).

---

## Techniques abordées

Le modèle entité-association :

- Rechercher les entités naturelles
- Attacher les propriétés appartenant à ces entités
- Déterminer les propriétés identifiantes
- Relier les entités par des associations
- Attacher les propriétés appartenant aux associations
- Déterminer les cardinalités des associations

---

## Travail à réaliser

### Domaine de l’étude

Gestion des plannings et notation des élèves dans un établissement scolaire.

### Liste des données recensées  
(présentées par ordre alphabétique)

- Matière enseignée (chaine 30)
- Nombre d’heures (entier 2,0)
- Nom de la classe (chaine 30)
- Nom de l’élève (chaine 20)
- Nom du professeur (chaine 30)
- Note (decimal 2,2)
- Numéro de salle (entier 2,0)
- Prénom de l’élève (chaine 20)

---

## Règles de gestion

- À chaque classe est attribuée une et une seule salle de cours.
- Dans une salle de cours ne s’installe qu’une seule classe.
- Chaque matière n’est enseignée que par un et un seul professeur.
- Un professeur peut enseigner plusieurs matières.
- Pour chaque classe et chaque matière est défini un nombre fixe d’heures de cours.
- À chaque élève est attribuée une seule note par matière.

---