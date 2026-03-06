<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Déroulé pédagogique – M1 S2**

## Industrialiser la configuration avec Bash & connecter avec OpenSSH

---

## **1 Comprendre Bash et le fonctionnement du Shell – 45 min**

**Objectifs :**

- Comprendre ce qu’est un shell, le rôle de Bash et sa place dans l’architecture Unix/Linux.

- Identifier les éléments du système : noyau, shell, utilisateur, permissions.

- Découvrir l’environnement console / terminal et ses usages en administration.

*(Supports : Présentation du shell Bash, Système UNIX/Linux, Console/Terminal)*

**Activités :**

- Présentation guidée :
  
  - Shell vs Terminal, exemples historiques (images p.4–6 du PDF Console)
  
  - Bash : rôle, histoire, limites, cas d’usage (automatisation, administration).
  
  - Arborescence Unix, utilisateurs / groupes / permissions.

- Mini-quiz oral : « Quelle commande… ? » / « À quoi sert Bash ? »

- Démonstration : ouverture terminal, navigation simple (`pwd`, `ls`, `cd`).

**Livrable court :**

- 1 fiche personnelle : “3 choses que permet Bash / 3 choses qu’il ne fait pas”.

---

## **2 Premières commandes & manipulation des fichiers – 1 h 15**

Basé sur : *Commandes Bash courantes* et *Présentation du Shell Bash*

**Objectifs :**

- Savoir se déplacer dans l'arborescence, manipuler fichiers/dossiers.

- Utiliser les commandes essentielles : navigation, aide, recherche, permissions.

- Utiliser pipes, redirections et premières commandes d’analyse.

**Activités :**

- Exercices guidés dans un dossier “lab” :
  
  - navigation (`pwd`, `ls`, `cd`)
  
  - création / suppression / copie / déplacement (`mkdir`, `cp`, `mv`, `rm`)
  
  - lire des fichiers (`cat`, `head`, `tail`, `less`)
  
  - chercher (`grep`, `find`)
  
  - permissions (`chmod`, `ls -l`)
  
  - redirections & pipes (`>`, `>>`, `|`)

- Analyse de sorties : comprendre les résultats et erreurs fréquentes.

**Livrables :**

- Fichiers produits dans le dossier `~/bash-lab` selon les consignes.

---

## **3 Premiers scripts & automatisation – 1 h 30**

Basé sur : *Premiers scripts*, *Mémo Bash*, *Exemples commentés*

**Objectifs :**

- Créer un premier script Bash fonctionnel.

- Comprendre shebang, exécution, variables, tests, boucles et menus simples.

- Analyser un script existant avant de l’exécuter.

**Contenu abordé :**

- Shebang, droits d’exécution (`chmod +x`).

- Variables, substitution, chaînes.

- Tests (`[[ ]]`), conditions, boucles `for/while`, menu `case`.

- Analyse de scripts : AskSysManV3.sh / cerbere.sh (document TP).

**Activités :**

- TP en binôme :
  
  - lecture et analyse de 2 scripts sans exécution (structure, commandes, logique)
  
  - rédaction d’une mini-analyse 3–5 lignes chacun (selon consignes du TP).

- Création d’un mini-script personnel : afficher informations système, date, dossier courant.

**Livrables :**

- 2 analyses courtes (AskSysManV3.sh + cerbere.sh).

- 1 script fonctionnel (`.sh`) validé en fin de séance.

---

## **4 Connexion distante sécurisée avec OpenSSH – 1 h 30**

Basé sur : *OpenSSH – Installation & utilisation*

**Objectifs :**

- Comprendre les principes d’une connexion sécurisée (SSH, chiffrement, clés).

- Installer et configurer OpenSSH-Server.

- Se connecter à une autre machine, transférer des fichiers.

**Travail à réaliser :**

- Installation :
  
  ```bash
  sudo apt install openssh-server
  sudo systemctl start ssh
  sudo systemctl enable ssh
  ```

- Configuration :
  
  - modification du port (22 → 25022),
  
  - test de connexion (`ssh -p 25022 utilisateur@IP`).

- Transfert de fichiers :  
  `scp -P 25022 fichier.txt user@server:~/`

- (optionnel) Activation pare-feu UFW et ouverture du port configuré.

**Livrables :**

- Connexion réussie sur une machine distante (capture / preuve terminal).

- 1 transfert de fichier réalisé via `scp`.

---

# **Résumé clair du déroulé**

1. **Shell & système** (45 min) – rôle de Bash, terminal, permissions

2. **Commandes de base** (1 h 15) – navigation, fichiers, pipes, recherches

3. **Scripts Bash** (1 h 30) – shebang, tests, boucles + analyse de scripts

4. **OpenSSH** (1 h 30) – installation, configuration, connexion sécurisée
