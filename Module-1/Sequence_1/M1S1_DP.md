<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Déroulé pédagogique  M1 S1**

### *Introduction aux systèmes d’exploitation & Installation de Linux*

---

## **1 Comprendre l’évolution des systèmes d’exploitation  45 min**

**Objectifs :**

- Situer les grandes familles de systèmes d’exploitation (UNIX, BSD, Linux, Windows, macOS).

- Comprendre la place centrale de Linux dans l’informatique moderne (serveurs, cloud, mobile).

- Identifier les différences techniques et historiques majeures.

**Activités :**

- Présentation guidée à partir du cours :
  
  - naissance d’UNIX (1969) et diffusion académique (BSD),
  
  - apparition de CP/M, MS-DOS et Windows,
  
  - création de GNU (1983) et Linux (1991),
  
  - évolution récente jusqu’en 2025 (mobile, cloud, conteneurs).  
    *(Supports : documents Histoire Linux et Histoire des OS)*

- Observation du diagramme historique (PlantUML) et repérage des trois grandes lignées OS.

- Mini-quiz oral : « À quelle famille appartient… ? »

**Livrable court :**

- 1 schéma simple (texte ou dessin) de l’arbre des trois familles : UNIX/BSD – GNU/Linux – Windows NT.

---

## **2 Manipulation du diagramme historique  1 h 15**

Basé sur : *Cours Histoire des systèmes d’exploitation*

**Objectifs :**

- Comprendre visuellement la chronologie et les influences entre OS.

- Utiliser un outil de diagramme textuel (PlantUML ou Mermaid) pour vérifier sa compréhension.

- Développer les compétences de lecture d’architecture technique.

**Activités :**

- Ouverture de l’éditeur PlantUML Web.

- Copie/Collage du script .puml fourni (arbre OS 1969 → 2025).

- Annotation du diagramme :
  
  - famille UNIX/BSD,
  
  - famille GNU/Linux + distributions + Android,
  
  - famille Windows (DOS → NT).

- Mini-exercice : ajouter une flèche d’influence ou un nœud (ex : ChromeOS, Fedora, Mint).

**Livrables :**

- 1 version annotée du diagramme OU

- 1 liste des trois lignées + 3 exemples de systèmes associés.

---

## **3 Installation guidée de Linux Mint  1 h 30**

Basé sur : *Linux – Installation et configuration*

**Objectifs :**

- Savoir installer un Linux moderne (Linux Mint).

- Comprendre les notions : ISO, boot, menu BIOS/UEFI, mode Live, partitionnement simple.

- Réaliser une première installation complète et fonctionnelle.

**Contenu abordé :**

- Démarrage sur clé USB (F2/F10/F12/DEL/ESC).

- Mode Live et installation :
  
  - langue, clavier, codecs tiers,
  
  - effacer le disque / installation simple,
  
  - création de l’utilisateur + mot de passe.

- Premier démarrage et mises à jour.

- Changement de miroirs Mint / Ubuntu (plus rapides).

- Commandes essentielles :
  
  ```
  sudo apt update  
  sudo apt upgrade  
  sudo reboot now
  ```

**Activités :**

- Installation réelle ou simulation pas-à-pas.

- Identification des étapes sur le support PDF.

- Manipulation du terminal (premières commandes).

**Livrables :**

- Linux Mint fonctionnel et mis à jour sur le poste.

- Première commande exécutée avec succès (capture ou retour terminal).

---

## **4 Mise en place de l’environnement de développement  1 h 30**

Basé sur : *Script Install_Mint_22_stable.sh* (présenté dans les documents)

**Objectifs :**

- Comprendre ce qu’est une installation automatisée.

- Mettre en place un environnement complet pour le développement web.

- Savoir exécuter un script Bash securisé.

**Travail à réaliser :**

- Téléchargement et exécution du script :
  
  ```
  wget https://github.com/RegameyManuel/Mint-Install-Script/blob/main/Install_Mint_22_stable.sh  
  chmod +x Install_Mint_22_stable.sh  
  ./Install_Mint_22_stable.sh
  ```

- Explication des blocs installés :
  
  - outils système + développement (GCC, git, curl, zip, etc.),
  
  - pile LAMP (Apache2, MariaDB, PHP),
  
  - outils applicatifs (Composer, Symfony CLI, DBeaver),
  
  - optimisations (PHP.ini, timezone, limites mémoire).

- Vérification du bon fonctionnement :
  
  - `apache2ctl -v`
  
  - `mysql --version`
  
  - `php -v`

**Livrables :**

- Environnement complet prêt pour les prochains modules.

- Terminal affichant les versions de Apache, MariaDB, PHP, Composer, Symfony CLI.

---

# **Résumé clair du déroulé**

1. **Histoire & familles OS** (45 min) – comprendre UNIX / Linux / Windows

2. **Manipulation du diagramme PlantUML** (1 h 15) – lecture & annotation

3. **Installation Linux Mint** (1 h 30) – ISO, live, installation, apt

4. **Environnement de dev** (1 h 30) – Script complet + outils web
