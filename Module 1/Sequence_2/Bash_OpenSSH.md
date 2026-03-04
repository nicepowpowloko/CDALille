<img src="../../Logo.png" width="550" height="75" alt="logo">



## Présentation de **OpenSSH**

**OpenSSH** (Open Secure Shell) est une suite d’outils permettant d’établir des connexions sécurisées entre des machines à travers un réseau. Elle est très utilisée dans les systèmes Unix/Linux (dont Debian, Ubuntu, Linux Mint, etc.) pour administrer des serveurs à distance, transférer des fichiers ou créer des tunnels sécurisés.

OpenSSH s'appuie sur le protocole **SSH**, qui chiffre les communications afin d’empêcher l’interception ou la modification des données transmises. C’est l’outil standard de connexion distante dans le monde Linux.

#### Principales fonctionnalités d’OpenSSH

OpenSSH fournit plusieurs programmes, parmi lesquels :

| Programme      | Rôle                                                                       |
| -------------- | -------------------------------------------------------------------------- |
| **ssh**        | Se connecter à une machine distante en ligne de commande                   |
| **sshd**       | Le service (daemon) qui accepte les connexions SSH sur la machine distante |
| **scp**        | Copier des fichiers entre machines via SSH                                 |
| **sftp**       | Transférer des fichiers via une interface similaire à FTP, mais sécurisée  |
| **ssh-keygen** | Créer et gérer des clés SSH pour l’authentification par clé publique       |

#### Exemples d’utilisation

| Action                              | Commande                                        |
| ----------------------------------- | ----------------------------------------------- |
| Se connecter à une machine distante | `ssh utilisateur@adresse_ip`                    |
| Copier un fichier vers un serveur   | `scp fichier.txt utilisateur@serveur:/dossier/` |
| Générer une paire de clés SSH       | `ssh-keygen -t ed25519`                         |



### 1. Installation d’OpenSSH-Server

1. Mettez à jour votre liste de paquets :
   
   ```bash
   sudo apt update
   ```

2. Installez le serveur SSH :
   
   ```bash
   sudo apt install openssh-server -y
   ```

3. Assurez-vous que le service SSH est en cours d’exécution et activé au démarrage :
   
   ```bash
   sudo systemctl start ssh
   sudo systemctl enable ssh
   ```

À ce stade, le serveur SSH écoute sur le port 22 par défaut.

---

### 2. Changer le port par défaut (22) vers un port personnalisé

1. Ouvrez le fichier de configuration SSH :
   
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```

2. Repérez la ligne contenant `#Port 22`. Décommentez-la (en enlevant le `#`) et remplacez 22 par un numéro de port à 4 chiffres, peu utilisé. Par exemple, utilisez `25022` :
   
   ```bash
   Port 25022
   ```

3. Sauvegardez le fichier (Ctrl+O puis Entrée) et quittez (Ctrl+X).

4. Redémarrez le service SSH pour appliquer les changements :
   
   ```bash
   sudo systemctl restart ssh
   ```
   
   ---

### 3. Configuration du pare-feu (facultatif mais recommandé)

Si vous utilisez `ufw` (Uncomplicated Firewall), ouvrez le nouveau port et fermez l’ancien :

1. Installez `ufw` si ce n’est pas déjà fait :
   
   ```bash
   sudo apt install ufw -y
   ```

2. Autorisez le nouveau port SSH :
   
   ```bash
   sudo ufw allow 25022/tcp
   ```

3. (Facultatif) Retirez l’autorisation du port 22 si elle existe :
   
   ```bash
   sudo ufw deny 22/tcp
   ```

4. Activez `ufw` si ce n’est pas déjà fait :
   
   ```bash
   sudo ufw enable
   ```

---

### 4. Connexion au serveur via SSH

Supposons que le nom du serveur est `SRV-DEB` et que son IP est `10.119.21.6`. Désormais, le serveur SSH écoute sur le port 25022.

Pour vous connecter depuis une machine cliente Linux ou macOS :

```bash
ssh -p 25022 utilisateur@10.119.21.6
```

(Remplacez `utilisateur` par le nom d’utilisateur disponible sur le serveur.)

Si vous disposez de la résolution DNS ou que le nom `SRV-DEB` est connu par le fichier `/etc/hosts`, vous pouvez également faire :

```bash
ssh -p 25022 utilisateur@SRV-DEB
```

---

### 5. Copier des fichiers vers le serveur

Pour copier un fichier depuis votre machine locale vers le serveur, utilisez `scp` (secure copy):

```bash
scp -P 25022 /chemin/vers/fichier_local utilisateur@10.119.21.6:/chemin/de/destination
```

Par exemple :

```bash
scp -P 25022 monfichier.txt utilisateur@10.119.21.6:~
```

Cela copie `monfichier.txt` dans le répertoire personnel de `utilisateur` sur le serveur.

Pour copier depuis le serveur vers votre machine locale, inversez l’ordre des chemins :

```bash
scp -P 25022 utilisateur@10.119.21.6:/chemin/du/fichier_sur_serveur fichier_local_sur_machine
```

---

### 6. Conseils de Sécurité

- Utilisez des clés SSH au lieu de mots de passe pour renforcer la sécurité.
- Gardez le système et les paquets à jour.
- Vérifiez que le pare-feu et éventuellement Fail2ban ou autre mécanisme de protection sont configurés pour limiter les tentatives de brute-force.
