<img src="../Logo.png" width="550" height="75">

# TP – Installation d’un serveur Linux, activation SSH, connexions stagiaires et création des comptes

## Objectifs

Installez Linux Mint sur un poste serveur. Activez le service SSH. Connectez-vous à distance depuis Windows. Chaque stagiaire crée son compte utilisateur et travaille dans son répertoire personnel. Le répertoire `/home/stagiaire` servira d’espace de dépôt des notes, scripts, devoirs et documents.

---

## Préparation

Un PC dédié : HP avec processeur i5, 16 Go de RAM et SSD NVMe 256 Go.  
Une clé USB Linux Mint.  
Les postes stagiaires sont sous Windows 11.

---

## 1) Installation de Linux (fait ensemble)

Démarrez la machine sur la clé USB.  
Lancez l’installation de Linux Mint.  
Utilisez le compte  suivant:

- Nom d’utilisateur : `hal`

- Mot de passe : `9000`

Redémarrez le PC après l’installation.

---

## 2) Mise à jour du système

Ouvrez un terminal sur la machine serveur :

```bash
sudo apt update
sudo apt upgrade -y
```

---

## 3) Installation et activation du serveur SSH

```bash
sudo apt install openssh-server -y
sudo systemctl enable --now ssh
sudo systemctl status ssh
```

Si le statut affiche `active (running)`, le service fonctionne.

---

## 4) Récupérez l’adresse IP de la machine serveur

```bash
ip a
```

Repérez une adresse du type `192.168.x.x`.

---

## 5) Connexion depuis les postes Windows 11

Sur les postes stagiaires, ouvrez Terminal Windows ou PowerShell :

```powershell
ssh hal@192.168.x.x
```

Acceptez la clé si demandé, saisir le mot de passe.

On est maintenant dans un terminal Bash distant.

Testez quelques commandes pour se repérer :

```bash
pwd
whoami
ls -l
uname -a
```

---

## 6) Chaque stagiaire crée son propre utilisateur

Toujours dans la session SSH, chaque stagiaire crée son utilisateur.  


```bash
sudo adduser stagiaire
```

Un mot de passe sera demandé.  
Validez les champs par défaut.

Vérifiez la création du répertoire personnel :

```bash
ls /home
```

On doit voir `/home/stagiaire`.

---

## 7) Chaque stagiaire se déconnecte et se reconnecte avec son propre compte

Déconnexion :

```bash
exit
```

Reconnectez :

```powershell
ssh hal@192.168.x.x
```

Vérifiez que l’on est dans son propre espace :

```bash
pwd
ls -a
```

---

## 8) Manipulations de base dans le répertoire personnel

Créez un dossier :

```bash
mkdir notes
```

Entrez dans ce dossier :

```bash
cd notes
```

Créez un fichier texte avec nano :

```bash
nano message.txt
```

Écrivez une phrase dedans puis enregistrez (`Ctrl + O`, Entrée, puis `Ctrl + X` pour quitter).

Affichez le contenu du fichier :

```bash
cat message.txt
```

Revenez au dossier utilisateur :

```bash
cd
```

Vérifiez l’arborescence :

```bash
ls -R
```

---

## 9) Déposez un premier document simple (preuve de fonctionnement)

```bash
echo "HAL, ouvre la porte s’il te plaît." > note.txt
ls -l
cat note.txt
```

Testez également :

```bash
nano note.txt
```

---

## 10) Hal peut visualiser les travaux

Sur le serveur, connecté en tant que Hal :

```bash
cd /home
ls -l
cd prenom
ls -l
```

## Conclusion

Le serveur Linux est installé. SSH fonctionne. Chaque stagiaire sait se connecter à distance en Bash. Les répertoires personnels existent et peuvent accueillir du code, des notes et des devoirs.

Les conditions sont maintenant réunies pour enchaîner sur les TP Bash (navigation, permissions, scripts, automatisation).

Bien sûr Hal, peux garder un oeil sur le travail des stagiaires.
