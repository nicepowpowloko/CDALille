<img src="../../Logo.png" width="550" height="75" alt="logo">

# **PARTIE 2 | Bash, commandes courantes**

### **Préparation du terrain (pour tester sans danger)**

```bash
mkdir -p ~/bash-lab   # Crée un dossier de travail dans le home (sans risque)
cd ~/bash-lab         # On se place dedans
```

### **Pour une documentation accessible en français, nativement sur votre système**

```bash
sudo apt update
sudo apt install manpages-fr
sudo mandb
```

---

## 1) **Navigation et aide**

### `pwd` – afficher le chemin du dossier actuel

```bash
pwd   # Affiche le chemin complet du répertoire dans lequel on est
```

### `ls` – lister les fichiers

```bash
ls           # Liste simple
ls -l        # Mode liste détaillée (droits, propriétaire, taille, date)
ls -a        # Affiche aussi les fichiers cachés (ceux qui commencent par .)
ls -lh       # Affiche les tailles de façon lisible (K, M, G…)
ls -lt       # Trie par date, le plus récent en premier
```

### `cd` – changer de répertoire

```bash
cd ~/bash-lab            # Aller dans notre espace de travail
mkdir -p demo/inner      # Créer une arborescence
cd demo/inner            # Descendre dedans
cd -                     # Revenir au dossier précédent
cd ..                    # Remonter dans l'arborescence des dossiers
```

### `man`, `--help` – obtenir de l’aide

```bash
man ls                   # Ouvre le manuel complet (q pour quitter)
ls --help | less         # Affiche l’aide rapide dans un pager
```

### `type`, `which`, `command -V` – savoir ce qu’est une commande

```bash
type cd                  # cd est un builtin ( intégré dans le shell )
which bash               # Affiche l'emplacement du binaire bash
command -V grep          # Affiche des infos détaillées sur grep
```

---

## 2) **Créer, copier, déplacer, supprimer**

### `touch` – créer un fichier vide

```bash
touch notes.txt          # Crée un fichier (ou met à jour sa date s’il existe déjà)
```

### `mkdir` – créer des dossiers

```bash
mkdir -p data/raw/2025   # -p crée aussi les dossiers parents si besoin
```

### `cp` – copier

```bash
echo "alpha" > a.txt     # Crée un fichier avec du contenu
cp a.txt b.txt           # Copie simple
cp -v a.txt data/        # -v = verbose → affiche ce qui est copié
cp -r data data_backup   # -r = copie récursive d’un dossier
```

### `mv` – renommer ou déplacer

```bash
mv b.txt b_old.txt       # Renomme un fichier
mv b_old.txt data/       # Déplace dans un dossier
mv data_backup data_old  # Renomme un dossier
```

### `rm` – supprimer

!!!!! **DANGER** : ne jamais utiliser `rm -rf /` ni `sudo rm` sans réfléchir !!!!!

```bash
rm notes.txt             # Supprime un fichier
rm -i a.txt              # -i demande confirmation (sécurisant pour débuter)
rm -r data_old           # -r supprime un dossier et tout son contenu
```

---

## 3) **Afficher et chercher dans les fichiers**

### `cat`, `tac`, `nl`

```bash
printf "un\ndeux\ntrois\n" > demo.txt   # Création d’un fichier multi-lignes
cat demo.txt                            # Affiche dans l’ordre
tac demo.txt                            # Affiche à l’envers
nl demo.txt                             # Ajoute les numéros de lignes
```

### `head`, `tail`

```bash
head -n 2 demo.txt    # Affiche les 2 premières lignes
tail -n 1 demo.txt    # Affiche la dernière ligne
```

### `less`

```bash
less demo.txt         # Affichage interactif → q pour quitter, /mot pour chercher
```

### `grep` – filtrer par motif

```bash
grep -n "deux" demo.txt      # -n affiche le numéro de la ligne
grep -i "UN" demo.txt        # -i ignore la casse (majuscule/minuscule)
grep -r "alpha" .            # -r cherche récursivement dans tous les fichiers
```

### `wc` – compter

```bash
wc -l demo.txt        # Nombre de lignes
wc -w demo.txt        # Nombre de mots
wc -c demo.txt        # Nombre d’octets
```

### `cut`, `sort`, `uniq`

```bash
printf "id;nom\n1;Ana\n2;Bob\n2;Bob\n" > table.csv

cut -d';' -f2 table.csv      # Extrait la 2e colonne (nom)
sort table.csv | uniq        # Retire les doublons consécutifs
sort table.csv | uniq -c     # Compte occurrences
```

---

## 4) **Redirections et pipes**

```bash
echo "alpha" > log.txt       # > crée ou écrase un fichier
echo "beta" >> log.txt       # >> ajoute à la fin

cat log.txt | grep "a"       # Pipe : la sortie de cat devient l’entrée de grep

ls /neXistePaS 2>&1 | grep "No such"  
# 2>&1 = redirige la sortie d’erreur vers la sortie standard
```

---

## 5) **Recherche de fichiers**

```bash
touch data1.txt data2.log                    # Prépare des fichiers
find . -type f -name "*.txt"                 # Tous les .txt
find . -type f -size -1M -print              # Fichiers < 1 Mo
find . -type f -name "*.log" -exec cp {} backup/ \;  
# Exécute une commande sur chaque fichier trouvé
```

---

## 6) **Permissions**

```bash
echo "secret" > secret.txt
chmod 600 secret.txt       # Propriétaire peut lire/écrire, personne d’autre
ls -l secret.txt           # Vérifier
chmod u+x secret.txt       # Ajoute x (exécution) au propriétaire
```

---

## 7) **Archives**

```bash
mkdir -p proj && echo "x" > proj/f.txt

tar -cvf proj.tar proj     # Crée une archive
tar -czvf proj.tar.gz proj # Archive + compression gzip
tar -xvf proj.tar -C extracted/   # Extraire dans un dossier
```

---

## 8) **Processus**

```bash
sleep 30 &                 # Lance une tâche en arrière-plan
jobs                       # Affiche les tâches du shell
pgrep sleep                # Trouve le PID du processus
kill %1                    # Termine la tâche n°1 du shell
```

---

## 9) **Réseau**

```bash
curl -I https://example.com   # Requête HTTP : affiche les en-têtes
ping -c 3 1.1.1.1             # Test de réseau, -c limite à 3 paquets
```

---

## 10) **Infos système**

```bash
uname -a        # Infos noyau OS
date            # Date/heure système
uptime          # Depuis combien de temps le système tourne
who             # Qui est connecté
df -h           # Espace disque
du -sh ~/bash-lab   # Taille du dossier courant
```
