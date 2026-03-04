<img src="../../Logo.png" width="550" height="75" alt="logo">

# TP Collaboratif Git & GitHub (Travail en Binôme / Trinôme)

**Objectif : apprendre à travailler à plusieurs sur un même projet.**

---

## Objectifs pédagogiques

À la fin du TP, vous serez capables de :

- Cloner un dépôt distant et travailler en local

- Créer et utiliser des **branches**

- Faire des **commits** clairs

- **Pousser** et **tirer** des modifications (`git push / git pull`)

- Ouvrir une **Pull Request**

- Faire une **revue de code**

- Résoudre **un conflit de merge**

- Fusionner dans `dev` puis `main`

---

## Organisation des groupes

Travaillez par **groupes de 2 ou 3**.

Dans chaque groupe :

| Rôle                     | Responsabilité                                              |
| ------------------------ | ----------------------------------------------------------- |
| **Responsable du dépôt** | crée le dépôt GitHub et ajoute les autres en collaborateurs |
| **Collaborateurs**       | travaillent dans le même dépôt, sur leurs propres branches  |

Tout le monde travaille **sur sa machine**.

---

## Mise en place du projet

### 1) Le responsable du dépôt

1. Aller sur GitHub → **Nouveau dépôt**

2. Nommer le projet :
   
   ```bash
   projet-collaboratif-noms_du_groupe
   ```

3. **Ne pas créer de README automatique.**

4. Sur votre machine :

```bash
git clone URL_DU_DEPOT
cd projet-collaboratif-noms_du_groupe
```

5. Créer l’architecture :

```bash
mkdir src
mkdir doc
```

6. Créer les fichiers de base :

```bash
echo "# Projet collaboratif" > README.md
echo '<!-- Documentation interne -->' > doc/notes.md
```

7. Ajouter + commit + push :

```bash
git add .
git commit -m "feat: initialisation du projet"
git push
```

### 2) Ajouter les collaborateurs

Le responsable :

GitHub → **Settings** → **Collaborators** → Add people

Les autres acceptent l’invitation.

---

## Les collaborateurs récupèrent le projet

```bash
git clone URL_DU_DEPOT
cd projet-collaboratif-noms_du_groupe
```

---

## Code de départ

Le responsable :

Créer le fichier suivant :

```bash
nano src/index.html
```

Collez :

```html
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Projet Collaboratif</title>
  <style>
    body { 
      font-family: Arial, sans-serif; 
      margin: 40px auto;
      max-width: 800px;
      line-height: 1.6;
      color: #222;
    }
    header, footer { text-align: center; padding: 1em; background: #f3f3f3; border-radius: 8px; }
    section { margin: 30px 0; padding: 20px; background: #fafafa; border-left: 6px solid #3498db; border-radius: 6px; }
    h1, h2 { color: #3498db; }
  </style>
</head>
<body>
  <header>
    <h1>Projet Collaboratif Git & GitHub</h1>
    <p>Travail d'équipe · Branches · Pull Requests · Conflits · Fusion</p>
  </header>

  <section id="groupe">
    <h2>Groupe</h2>
    <p>Liste des membres et rôles</p>
  </section>

  <section id="contributions">
    <h2>Contributions</h2>
    <p>Chaque membre ajoute sa section ici.</p>
  </section>

  <footer>
    <p>Projet créé dans le cadre du TP Git collaboratif</p>
  </footer>
</body>
</html>
```

Commit & push :

```bash
git add src/index.html
git commit -m "feat: ajout base HTML stylée"
git push
```

---

## Travail en branches (obligatoire)

Chaque membre crée **sa propre branche** :

```bash
git checkout -b feature/prenom-section
```

Exemple :

```bash
git checkout -b feature/sara-section
```

Modifier **uniquement la section** `<section id="contributions">`.

Ajouter, commit, push :

```bash
git add src/index.html
git commit -m "feat: ajout de la section Sara"
git push origin feature/sara-section
```

---

## Mettre à jour sa branche avant de continuer

Toujours :

```bash
git checkout main
git pull
git checkout feature/prenom
git merge main
```

---

## Pull Request + Review

Sur GitHub :

1. **New Pull Request**

2. Source = votre branche  
   Cible = `dev` (ou `main` si pas de branche dev)

3. Ajoutez un message clair

4. **Demandez une review** à un membre du groupe

5. Le reviewer :
   
   - lit le code
   
   - commente si nécessaire
   
   - approuve → merge

---

## Phase Conflit (volontaire & pédagogique)

Deux membres modifient **la même phrase** dans `<section id="contributions">`  
→ Push → Merge → Conflit.

Résolution :

```bash
nano src/index.html
```

Chercher :

```bash
<<<<<<< HEAD
...
=======
...
>>>>>>> feature/xxx
```

Garder / fusionner → puis :

```bash
git add src/index.html
git commit
git push
```

---

## Fusion finale

Une fois toutes les PR vers `dev` faites :

```bash
git checkout main
git pull
git merge dev
git push
```

Le site final est visible dans `src/index.html`.

---

## Ce que vous devez avoir à la fin

- 1 dépôt GitHub commun

- 1 fichier HTML contenant les sections de chaque membre

- 1 historique **propre**

- Au moins **1 Pull Request chacun**

- Au moins **1 conflit résolu en groupe**

---

## Rappels importants (à retenir)

| Action                   | Commande                  |
| ------------------------ | ------------------------- |
| Voir l’état              | `git status`              |
| Voir les changements     | `git diff`                |
| Commiter                 | `git commit -m "message"` |
| Changer de branche       | `git checkout branche`    |
| Créer une branche        | `git checkout -b branche` |
| Envoyer en ligne         | `git push origin branche` |
| Récupérer les nouveautés | `git pull`                |
| Fusionner                | `git merge branche`       |
