<img src="../../Logo.png" width="550" height="75" alt="logo">

# FICHE GIT + GH (GitHub CLI)

*Travail collaboratif en ligne de commande*

## Objectif

Utiliser **GitHub** sans passer par l’interface web :  
→ créer des dépôts, issues, pull requests, reviews, merges **depuis le terminal**.

---

## 1) **Installation & authentification**

### Installation (Linux / macOS / Windows officiel)

```bash
sudo apt install gh       # Debian / Ubuntu
brew install gh           # macOS / Linux Homebrew
choco install gh          # Windows (chocolatey)
```

### Connexion à GitHub

```bash
gh auth login
```

> Sélectionner : GitHub.com → HTTPS → Browser → Valider.

---

## 2) **Créer ou cloner un dépôt GitHub**

### Créer un nouveau repo sur GitHub **depuis le terminal**

```bash
gh repo create nom-du-repo --public --clone
```

Options possibles :

| Option       | Effet                                        |
| ------------ | -------------------------------------------- |
| `--private`  | repo privé                                   |
| `--public`   | repo ouvert                                  |
| `--clone`    | clone directement en local                   |
| `--source=.` | transforme ton dossier actuel en repo GitHub |

### Cloner un repo existant

```bash
gh repo clone utilisateur/nom-du-repo
```

---

## 3) **Pull Requests (PR)**

### Créer une Pull Request depuis la branche actuelle

```bash
gh pr create
```

L’assistant demande :

- titre

- description

- branche cible

### Avec options directes (plus rapide)

```bash
gh pr create --base dev --title "feat: ajout section" --body "Ajout complet du composant"
```

### Liste des PR ouvertes

```bash
gh pr list
```

### Voir une PR

```bash
gh pr view 17       # par numéro
gh pr view --web    # ouvre dans navigateur
```

### Ajouter une review

```bash
gh pr review --approve
gh pr review --request-changes -b "Explique ce qui manque ici…"
```

### Fusionner une PR

```bash
gh pr merge 17 --merge      # merge classique
gh pr merge 17 --squash     # compressé en 1 commit
gh pr merge 17 --rebase     # rebase + merge
```

---

## 4) **Issues (tickets de travail)**

Créer une nouvelle issue :

```bash
gh issue create --title "Bug page accueil" --body "Étapes pour reproduire..."
```

Voir les issues :

```bash
gh issue list
```

Lire une issue :

```bash
gh issue view 5
```

Assigner une issue :

```bash
gh issue edit 5 --add-assignee @moi
```

Fermer une issue :

```bash
gh issue close 5
```

---

## 5) **Collaborateurs & permissions**

Ajouter un collaborateur :

```bash
gh repo edit --add-collaborator userName
```

Changer la visibilité d’un dépôt :

```bash
gh repo edit --visibility public
gh repo edit --visibility private
```

---

## 6) **Workflow recommandé en équipe (100% CLI)**

```bash
# 1) Mettre à jour
git checkout main
git pull

# 2) Créer branche de feature
git checkout -b feature/<prenom>-tache
git add .
git commit -m "feat: description claire"
git push -u origin feature/<prenom>-tache

# 3) Créer Pull Request
gh pr create --base dev --title "<résumé>" --body "<détails>"

# 4) Review d'un binôme
gh pr list
gh pr view <num>
gh pr review <num> --approve

# 5) Fusion
gh pr merge <num> --merge
```

---

## 7) **Pseudo-code mental (simplification)**

```bash
Je travaille → git add → git commit
Je veux partager → git push
Je veux proposer → gh pr create
Je veux valider quelqu’un → gh pr review --approve
Je veux intégrer → gh pr merge
```
