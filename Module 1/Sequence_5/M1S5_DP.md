<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Déroulé pédagogique  M1 S5**

## Introduction à Docker & Docker Compose

---

## **1 Comprendre les conteneurs & l’écosystème Docker  45 min**

**Objectifs :**

- Comprendre pourquoi Docker est devenu central dans le développement moderne.

- Distinguer conteneur / machine virtuelle.

- Identifier les briques indispensables : images, conteneurs, registres, ports, volumes.

- Situer les différences Linux / Windows et l’importance du noyau Linux.

**Supports utilisés :**

- *Introduction_Docker.md* (historique, principes, architecture Linux vs WSL2, p.16)  

- Diagramme vertical Linux vs Windows (p.2 du support)

- Exemples concrets : lancer une base MariaDB sans installer MariaDB sur la machine.

**Activités :**

- Présentation guidée : conteneurs vs VM (section 0 & 1 du support).

- Lecture du diagramme Linux/WSL (page illustrée du support).

- Échanges : “Quels problèmes Docker résout ?”.

---

## **2 Manipuler ses premiers conteneurs Docker  1 h 15**

Basé sur : *Introduction Docker  sections installation & commandes*  

**Objectifs :**

- Installer et vérifier Docker.

- Lancer des conteneurs simples.

- Comprendre l’exécution, l’arrêt, les logs, l’accès terminal.

**Contenu abordé :**

- Installation officielle (APT + keyrings).

- Commandes essentielles :
  
  - `docker run hello-world`
  
  - `docker ps -a`
  
  - `docker stop`, `docker rm`
  
  - `docker logs`, `docker exec -it <service> bash`

**Activités :**

- Lancement de `hello-world`.

- Lancement d’un conteneur MariaDB simple :
  
  ```bash
  docker run -d -p 3309:3306 mariadb
  ```

- Vérification des ports (diagramme p.4 & explications p.3 du PDF compose).  

- Exploration du conteneur via `exec`.

**Livrables :**

- 1 capture terminal montrant un conteneur lancé + `docker ps`.

---

## **3 Découvrir Docker Compose : orchestrer plusieurs services  1 h 30**

Basé sur : *compose.pdf* (ports, volumes, exemples complets)  

**Objectifs :**

- Comprendre le rôle d’un fichier `docker-compose.yml`.

- Démarrer une stack complète : MariaDB + Adminer / phpMyAdmin.

- Comprendre ports, volumes, réseaux internes Docker.

**Contenu abordé :**

- Syntaxe basée sur les pages :
  
  - **p.34** : ports et redirection, schéma visuel
  
  - **p.56** : volumes (persistance)
  
  - **p.712** : exemples réels (MariaDB, Adminer, phpMyAdmin, Mailhog)

**Activités :**

- Création d’un fichier `compose.yml` minimal issu de l’exemple p.9 :
  
  ```yaml
  services:
    db:
      image: mariadb
      environment:
        MARIADB_ROOT_PASSWORD: Plouf1234
      volumes:
        - ./data:/var/lib/mysql
      ports:
        - 3309:3306
    adminer:
      image: adminer
      ports:
        - 8080:8080
  ```

- Démarrage de la stack :  
  `docker compose up -d`

- Vérification :
  
  - Adminer disponible → [http://localhost:8080](http://localhost:8080/)
  
  - Base accessible

- Manipulation des volumes (répertoire `./data`).

- Observation réseau interne via diagramme du support (similarité avec p.4 & p.6).

**Livrables :**

- Un dossier avec `compose.yml` fonctionnel + conteneurs visibles via `docker compose ps`.

---

## **4 Construire ses propres images : introduction au Dockerfile  1 h 30**

Basé sur : *compose_dockerfile.pdf* (Dockerfile sur mesure, stack PHP 8.4)  

**Objectifs :**

- Comprendre le rôle du Dockerfile et l’instruction `FROM`.

- Construire une image personnalisée.

- Lier Dockerfile & Compose via `build:`.

- Découvrir une stack PHP complète (PHP8.4, Composer, Symfony, Xdebug).

**Contenu abordé :**

- Lecture du Dockerfile p.26 :
  
  - `FROM debian:12`
  
  - `RUN apt-get update`
  
  - installation PHP 8.4
  
  - installation Symfony CLI
  
  - installation Composer

- Couplage via Compose (p.3 & p.7).

- Commandes :
  
  - `docker compose build`
  
  - `docker compose up`
  
  - `docker compose exec web bash`

**Activités :**

- Reproduction d’un Dockerfile minimal (FROM + RUN + WORKDIR).

- Build + lancement d’un conteneur personnalisé affichant `php -v`.

- Observation du Dockerfile complet sur ton support pour compréhension (page 6 du PDF).

**Livrables :**

- 1 Dockerfile minimal fonctionnel.

- 1 capture de `php -v` depuis un conteneur personnalisé.

---

## **5 Mise en pratique : créer une mini-stack web complète  1 h 30**

Basé sur :  
*Section 8 du support principal (TP stack complète)*

- exemples Compose (p.812)

**Objectifs :**

- Rassembler les notions vues : conteneurs · Compose · ports · volumes · réseau.

- Créer une architecture simple et fonctionnelle.

**Travail demandé :**

Créer un dossier `docker-lab` contenant :

1. Un `www/index.php` :
   
   ```php
   <?php echo "Docker OK - " . date('Y-m-d H:i:s'); ?>
   ```

2. Un `docker-compose.yml` comportant 3 services :
   
   - web (Apache/PHP) exposé en 8080
   
   - db (MariaDB) exposé en 3309
   
   - adminer en 8081

3. Au moins :
   
   - 1 port redirigé
   
   - 1 volume persistant
   
   - 1 réseau interne par défaut

Commandes à réaliser :  
`docker compose up -d`  
`docker compose exec web bash`  
`docker compose down -v` (remise à zéro).

**Livrables :**

- Stack complète fonctionnelle.

- Capture d’écran Adminer connecté à MariaDB.

- Page PHP accessible en [http://localhost:8080](http://localhost:8080/).

---

# **Résumé clair du déroulé**

1. **Concepts Docker** (45 min)  
   conteneurs vs VM, images, Linux vs Windows, premiers conteneurs.

2. **Docker CLI** (1 h 15)  
   run, stop, logs, exec, premiers tests (hello-world, MariaDB).

3. **Docker Compose** (1 h 30)  
   ports (p.4), volumes (p.6), services (p.812), stack web simple.

4. **Dockerfile & Build** (1 h 30)  
   construction d’image, FROM, RUN, build + stack PHP/Symfony.

5. **TP architecture complète** (1 h 30)  
   PHP + MariaDB + Adminer, volumes, ports, réseau interne.
