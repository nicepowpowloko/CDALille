<img src="../../Logo.png" width="550" height="75" alt="logo">

# FICHE RÉFLEXE GIT POUR TRAVAIL COLLABORATIF

## 1) **Principes de base (non négociables)**

| Principe                                 | Pourquoi                                               |
| ---------------------------------------- | ------------------------------------------------------ |
| **Une fonctionnalité = une branche**     | Évite de mélanger les travaux et simplifie les merges. |
| **Un commit = une intention claire**     | Lisibilité + historique compréhensible.                |
| **Toujours `pull` avant de `push`**      | Évite les conflits explosifs tardifs.                  |
| **Ne jamais coder dans `main`**          | `main` doit rester stable.                             |
| **Lire avant d’agir (`status`, `diff`)** | On n’agit jamais "en aveugle".                         |

---

## 2) **Workflow standard d’équipe**

```
main  ← stable
dev   ← travaux collectifs
feature/mon-travail ← branche personnelle
```

### **Créer et commencer une fonctionnalité**

```
git checkout main
git pull
git checkout -b feature/nom-clair
```

---

## 3) **Boucle de travail locale**

### **Voir l’état du projet**

```
git status
```

### **Voir ce qui a changé**

```
git diff
```

### **Ajouter les modifications**

```
git add fichier.ext
git add .        # si tout est assumé
```

### **Créer un commit propre**

```
git commit -m "feat: description courte"
```

Messages recommandés (convention Angular simplifiée) :

| Type        | Usage                                        |
| ----------- | -------------------------------------------- |
| `feat:`     | nouvelle fonctionnalité                      |
| `fix:`      | correction                                   |
| `docs:`     | documentation                                |
| `refactor:` | modification sans changement de comportement |
| `style:`    | indentation / formatage                      |
| `test:`     | tests ajoutés ou modifiés                    |

Exemple :

```
git commit -m "feat: ajout formulaire d'inscription"
```

---

## 4) **Envoyer son travail (avec précaution)**

### **Toujours récupérer avant d’envoyer :**

```
git pull origin feature/nom
```

### **Puis pousser :**

```
git push origin feature/nom
```

---

## 5) **Mettre son travail en commun**

Sur GitHub / GitLab :  
Créer une **Pull Request** → Demande de révision.

**Règles :**

- Titre clair

- Résumé des changements

- Screens / captures si front

- Pas de 200 commits "test"

**Jamais** merger seul si on n’est pas sûr.

---

## 6) **Fusionner (`merge`)**

### Depuis la branche cible (`main` ou `dev`) :

```
git checkout dev
git pull
git merge feature/nom
```

### Si pas de conflit :

```
git push
```

---

## 7) **Résoudre un conflit**

Git marque les zones en désaccord :

```
<<<<<<< HEAD
version locale
=======
version venant de l'autre branche
>>>>>>> feature/nom
```

### Étapes de résolution :

1. **Ouvrir le fichier**

2. Garder / mélanger les bonnes lignes

3. Enregistrer

4. Dire à Git que c’est réglé :
   
   ```
   git add fichier
   git commit
   ```

---

## 8) **Annuler / corriger proprement**

| Cas                                             | Commande                                     | Effet                                    |
| ----------------------------------------------- | -------------------------------------------- | ---------------------------------------- |
| Annuler modifications non enregistrées          | `git restore fichier`                        | Retour version précédente                |
| Retirer un fichier du staging                   | `git restore --staged fichier`               | Annule le `git add`                      |
| Modifier le dernier commit (message ou contenu) | `git commit --amend`                         | Réécrit le dernier commit                |
| Revenir à un commit sans perdre l’historique    | `git revert hash`                            | Crée un commit inverse                   |
| Naviguer dans l’historique                      | `git log`, `git log --oneline --graph --all` | Comprendre l’état                        |
| Revenir si catastrophe                          | `git reflog`                                 | Historique **de tout** ce qui a été fait |

---

## 9) **Mise à jour régulière du travail**

### **Mettre sa branche à jour avec `dev`**

```
git checkout feature/nom
git pull
git merge dev
# résoudre les conflits
git push
```

(ou `rebase` si l’équipe maîtrise → à introduire plus tard)

---

## 10) **Organisation des branches**

Nommer clairement :

```
feature/api-auth
feature/page-accueil
fix/bug-de-connexion
refactor/form-validation
```

Pas de :

```
toto
test
nouvelle-branche-19
```

---

## 11) **Checklist “je push”**

Avant chaque `git push` :

- `git status` est propre

- pas de console.log / code de debug inutile

- commit(s) clairs, pas 12 commits "update"

- j'ai **pull** AVANT de push :
  
  ```
  git pull origin feature/nom
  ```

---

## 12) **Résumé ultra-court (à retenir par cœur)**

```
git checkout -b feature/nom
git add .
git commit -m "message"
git pull
git push
ouvrir Pull Request
```
