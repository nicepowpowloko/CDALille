<img src="../../Logo.png" width="550" height="75" alt="logo">

## Présentation de **APT** (Advanced Package Tool)

APT (Advanced Package Tool) est un gestionnaire de paquets utilisé dans les distributions basées sur Debian, comme Ubuntu, Linux Mint (y compris LMDE), etc. Il simplifie l'installation, la mise à jour et la gestion des logiciels en automatisant la gestion des dépendances.

#### Principales fonctionnalités d'APT

APT fonctionne avec les dépôts de logiciels pour télécharger, installer, mettre à jour et désinstaller des programmes. Voici les principales commandes pour utiliser APT :

### 1. **Mise à jour des paquets et du système**

##### **`sudo apt update`** :

- Cette commande met à jour la liste des paquets disponibles dans les dépôts, sans pour autant installer les mises à jour.

- Elle compare les versions de paquets installés sur votre système avec celles des dépôts et prépare le système pour les mises à jour.

- Exemple :
  
  ```bash
  sudo apt update
  ```

##### **`sudo apt upgrade`** :

- Une fois que la liste des paquets est à jour, `apt upgrade` installe les mises à jour des paquets existants sur votre système.

- Contrairement à `dist-upgrade`, elle n'ajoute ni ne supprime de paquets.

- Exemple :
  
  ```bash
  sudo apt upgrade
  ```

##### **`sudo apt full-upgrade`** :

- Cette commande met à jour tout le système, y compris les modifications des dépendances (parfois en ajoutant ou en supprimant des paquets).

- Exemple :
  
  ```bash
  sudo apt full-upgrade
  ```

---

### 2. **Recherche de paquets**

##### **`apt search <nom_du_paquet>`** :

- Rechercher un paquet spécifique par son nom ou sa description. Cela permet de voir tous les paquets liés à un terme de recherche donné.

- Exemple :
  
  ```bash
  apt search firefox
  ```

##### **`apt show <nom_du_paquet>`** :

- Obtenez des détails sur un paquet, tels que sa description, sa version, sa taille et ses dépendances.

- Exemple :
  
  ```bash
  apt show apache2
  ```

---

### 3. **Installation de paquets**

##### **`sudo apt install <nom_du_paquet>`** :

- Installe un paquet et toutes ses dépendances.

- Exemple :
  
  ```bash
  sudo apt install vim
  ```

##### **Installer plusieurs paquets** :

- Vous pouvez également installer plusieurs paquets à la fois.

- Exemple :
  
  ```bash
  sudo apt install vim git curl
  ```

---

### 4. **Désinstallation de paquets**

##### **`sudo apt remove <nom_du_paquet>`** :

- Désinstalle un paquet mais conserve ses fichiers de configuration.

- Exemple :
  
  ```bash
  sudo apt remove apache2
  ```

##### **`sudo apt purge <nom_du_paquet>`** :

- Désinstalle un paquet et supprime également ses fichiers de configuration.

- Exemple :
  
  ```bash
  sudo apt purge apache2
  ```

---

### 5. **Nettoyage du système**

##### **`sudo apt autoremove`** :

- Supprime les paquets et dépendances inutilisés qui ont été installés automatiquement mais ne sont plus nécessaires.

- Exemple :
  
  ```bash
  sudo apt autoremove
  ```

##### **`sudo apt clean`** :

- Supprime tous les fichiers téléchargés par APT (dans `/var/cache/apt/archives`) pour libérer de l'espace.

- Exemple :
  
  ```bash
  sudo apt clean
  ```

##### **`sudo apt autoclean`** :

- Supprime uniquement les fichiers obsolètes des paquets, c'est-à-dire ceux qui ne sont plus disponibles dans les dépôts.

- Exemple :
  
  ```bash
  sudo apt autoclean
  ```

---

### Conclusion

APT est un outil puissant pour gérer les logiciels sur des systèmes basés sur Debian. Grâce à ses commandes simples et efficaces, il permet d'installer, mettre à jour, désinstaller et nettoyer votre système de manière fluide.
