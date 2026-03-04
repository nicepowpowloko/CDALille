<img src="../../Logo.png" width="550" height="75" alt="logo">

# Installation et utilisation de **Laragon** sous Windows 10 et 11

Environnement de développement PHP / Symfony

## 1. Objectif de cette documentation

Cette documentation a pour but de :

* Mettre en place un environnement de développement web **simple, fiable et reproductible** sous Windows
* Comprendre les composants d’un stack PHP moderne
* Installer et utiliser **Laragon** pour développer des projets PHP et Symfony
* Uniformiser les environnements de travail sous Windows

---

## 2. Pourquoi Laragon ?

Laragon est un environnement de développement **orienté développeurs**.

### Avantages principaux

* Portable et léger
* Installation rapide
* Gestion automatique du Virtual Host
* Compatible Symfony, Laravel, PHP natif
* Intégration facile avec Composer, MariaDB, Node.js
* Très peu de configuration manuelle

---

## 3. Prérequis

* Windows 10 ou Windows 11 (64 bits)
* Droits administrateur sur la machine
* Connexion Internet

---

## 4. Installation de Chocolatey (gestionnaire de paquets Windows)

Chocolatey permet d’installer des outils en ligne de commande, comme `apt` sous Linux.

### 4.1 Ouvrir PowerShell en mode administrateur

* Clic droit sur le menu Démarrer ou `Windows`+ `x` (plus simple)
* **Windows PowerShell (Admin)**

### 4.2 Installer Chocolatey

Copier-coller la commande suivante :

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### 4.3 Vérifier l’installation

```powershell
choco --version
```

Si une version s’affiche, Chocolatey est correctement installé.

---

## 5. Installation des outils nécessaires

Nous allons installer l’ensemble des outils utiles au développement PHP / Symfony.

### 5.1 Installation via Chocolatey

Dans PowerShell (toujours en mode administrateur) :

```powershell
choco install composer -y
choco install laragon -y
choco install symfony-cli -y
```

Remarques :

* `-y` accepte automatiquement les confirmations
* Laragon inclut déjà PHP, MariaDB et Apache

---

## 6. Vérification de l’environnement

Fermer PowerShell, puis **le rouvrir (mode normal suffit)**.

### 6.1 Vérifier Composer

```powershell
composer --version
```

### 6.2 Vérifier Symfony CLI

```powershell
symfony --version
```

### 6.3 Vérifier MariaDB / MySQL(si installé nativement)

```powershell
mysql --version
```

Si les commandes répondent, les variables d’environnement (PATH) sont correctement configurées.

---

## 7. Découverte de Laragon

### 7.1 Lancer Laragon

* Menu Démarrer → Laragon → **Laragon**
* Cliquer sur **Start All**

Les services suivants démarrent :

* Apache (serveur web)
* MariaDB (base de données)
* PHP

### 7.2 Interface Laragon

Laragon propose :

* Bouton Start / Stop
* Accès rapide à :

  * Terminal
  * php.ini
  * MariaDB
  * Répertoires projets

---

## 8. Structure des projets avec Laragon

Par défaut, les projets sont stockés dans :

```bash
C:\laragon\www
```

Chaque dossier correspond automatiquement à un site web.

Exemple :

```bash
C:\laragon\www\cassandre
```

Accessible via navigateur à :

```bash
http://cassandre.test
```

Laragon gère automatiquement le Virtual Host.

---

## 9. Création d’un projet Symfony avec Laragon

### 9.1 Ouvrir le terminal Laragon

Dans Laragon :

* Menu → **Terminal**

### 9.2 Se placer dans le dossier www

```bash
cd C:\laragon\www
```

### 9.3 Créer un projet Symfony

```bash
symfony new cassandre --webapp
```

Ou avec Composer :

```bash
composer create-project symfony/skeleton cassandre
cd cassandre
composer require webapp
```

---

## 10. Lancer le serveur Symfony

Deux possibilités :

### Option 1 – Serveur Symfony (recommandé)

```bash
cd cassandre
symfony serve
```

Accès via :

```bash
http://localhost:8000
```

### Option 2 – Apache Laragon

* Vérifier que le projet est dans `www`
* Accès via :

```bash
http://cassandre.test
```

---

## 11. Accès à la base de données MariaDB

### 11.1 Identifiants par défaut

| Élément      | Valeur    |
| ------------ | --------- |
| Hôte         | localhost |
| Port         | 3306      |
| Utilisateur  | root      |
| Mot de passe | (vide)    |

### 11.2 Utilisation de HeidiSQL

* Lancer HeidiSQL
* Créer une nouvelle session MariaDB
* Se connecter avec les identifiants ci-dessus

---

## 12. Variables d’environnement (PATH)

### Pourquoi c’est important ?

Le PATH permet d’exécuter :

* `php`
* `composer`
* `symfony`
  depuis n’importe quel terminal.

Chocolatey et Laragon configurent cela automatiquement, mais en cas de problème :

* Paramètres Windows
* Système
* Informations système
* Paramètres système avancés
* Variables d’environnement

---

## 13. Bonnes pratiques en formation

* Toujours lancer Laragon **avant** de travailler
* Créer **un projet = un dossier**
* Utiliser Git dès le début du projet
* Centraliser les projets dans `C:\laragon\www`

---

## 14. Problèmes courants

### Port 80 occupé

* Skype (si vous avez encore Skype posez-vous des questions :D !!! )
* IIS
* Docker

Solution :

* Désactiver IIS
* Changer le port Apache dans Laragon

### Commande non reconnue

* Redémarrer PowerShell
* Vérifier le PATH
* Redémarrer la machine si nécessaire

---

## 15. Conclusion pédagogique

Laragon est :

* Un excellent compromis entre simplicité et professionnalisation
* Adapté aux stagiaires débutants comme avancés
* Un pont naturel entre Windows et les environnements Linux

Il permet de se concentrer sur :

* le code
* l’architecture MVC
* Symfony
  plutôt que sur la configuration système.
