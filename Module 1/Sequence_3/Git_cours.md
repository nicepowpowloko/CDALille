<img src="../../Logo.png" width="550" height="75" alt="logo">

# Versionner avec Git & Collaborer avec GitHub

Support de cours

## Objectifs

À la fin de ce module, vous serez capables de :

- Utiliser Git en local (init, add, commit, log)
- Travailler à plusieurs sur un même projet via **GitHub**
- Créer et utiliser des **branches** pour isoler votre travail
- **Pousser** et **tirer** des modifications entre machines
- Proposer une modification via **Pull Request**
- Fusionner (merge) et résoudre un conflit simple

---

## 1) Pourquoi utiliser Git ?

| Sans Git                               | Avec Git                              |
| -------------------------------------- | ------------------------------------- |
| On écrase les fichiers                 | Historique complet traçable           |
| Impossible de revenir en arrière       | On peut restaurer n'importe quel état |
| On travaille tous dans le même fichier | Chacun travaille sur **sa branche**   |
| Conflits permanents                    | Collaboration organisée et prévisible |

→ **Git est une machine à remonter le temps + un outil de travail en équipe.**

---

## 2) Notions essentielles

| Notion       | Rôle                                     |
| ------------ | ---------------------------------------- |
| Dépôt (repo) | Le projet versionné                      |
| Commit       | Une photo de l’état du code à un instant |
| Branche      | Une “ligne parallèle” de développement   |

---

## 3) Workflow d’équipe (standard et obligatoire dans le TP)

```bash
main → version stable (propre, livrable)  
dev → intégration en cours  
feature/-<tâche> → travail individuel
```

**Règle d’or :**

> **On ne travaille jamais directement dans `main`.**

---

## 4) Boucle de travail locale

| Étape                    | Commande(s)                           | Rappel                        |
| ------------------------ | ------------------------------------- | ----------------------------- |
| Voir l’état              | `git status`                          | Toujours avant de commit      |
| Voir ce qui a changé     | `git diff`                            | Lire avant d’agir             |
| Ajouter                  | `git add fichier` ou `git add .`      | Ne pas ajouter n’importe quoi |
| Commit                   | `git commit -m "feat: message clair"` | 1 commit = 1 idée             |
| Envoyer en ligne         | `git push origin ma-branche`          | **jamais sur main**           |
| Récupérer les nouveautés | `git pull`                            | Toujours avant push           |

---

## 5) Branches

Créer une branche de travail :

```bash
git checkout -b feature/-section
```

Changer de branche :

```bash
git checkout main
```

Fusionner une branche dans une autre :

```bash
git checkout dev  
git merge feature/-section
```

---

## 6) Pull Request (PR)

Une **PR** sert à :

- Proposer un changement
- Être relu / validé par un autre
- Discuter le code
- Fusionner proprement dans `dev` ou `main`

Ce n’est **pas** une commande Git :
→ cela se fait **dans GitHub**.

---

## 7) Conflits

Ils arrivent quand deux branches modifient **la même ligne**.

Git marque les zones à résoudre :

```bash
# <<<<<<< HEAD

(ce qui est dans la branche où vous êtes)

(ce qui arrive avec le merge)

> > > > > > > feature/nom
```

### Pour résoudre :

1. Ouvrir le fichier
2. Choisir / fusionner les versions
3. Sauvegarder
4. `git add fichier`
5. `git commit`

---

## 8) Ce que vous allez faire maintenant (TP Collaboratif)

Par groupes de **2 ou 3** :

- Un membre crée le dépôt GitHub

- Les autres sont ajoutés comme **collaborateurs**

- Chacun crée **sa branche feature**

- Chacun ajoute une **section** dans `src/index.html`

- Chacun ouvre une **Pull Request**

- Le groupe **fait des reviews**

- Puis : **fusion** → et enfin résolution d’un **conflit volontaire**
  
  **Vous allez maintenant passer à :**  
  `TP_Collaboratif_Git_GitHub.md`
