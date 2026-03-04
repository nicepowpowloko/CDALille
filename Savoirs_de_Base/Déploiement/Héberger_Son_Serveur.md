# Déployer un site PHP chez soi (Debian / Raspberry Pi) - Processus guidé

## Pourquoi faire ça ?

L’hébergement local (sur un Raspberry Pi ou une machine Debian) permet de comprendre tout ce qu’on délègue habituellement au cloud: réseau, sécurité, certificats, serveur web, et maintenance.
C’est une démarche très utile pour la souveraineté numérique: on garde la main sur la machine, les données, et le mode de fonctionnement. Cela demande un peu plus de rigueur, mais c’est extrêmement formateur.

Dans ce parcours, l’idée n’est pas d’avoir “un site qui marche vite”, mais de comprendre:

* comment une requête HTTP/HTTPS arrive sur la machine,
* comment on limite la surface d’attaque,
* comment on garde un minimum de maintenabilité.

---

## Les outils et leur utilité (pourquoi on les utilise ici)

* **Apache2**: le serveur web. Il reçoit les requêtes sur 80/443 et sert les fichiers, exécute PHP (via module ou PHP-FPM), gère des “sites” via VirtualHosts.
* **OpenSSH (sshd + ssh)**: accès distant sécurisé à la machine (administration). En prod, SSH est le canal de pilotage du système.
* **UFW**: pare-feu simple. Il dit “j’accepte uniquement ce dont j’ai besoin” (80/443/SSH) et refuse tout le reste.
* **Fail2Ban**: surveillance + bannissement automatique des IP qui tentent des connexions répétées (bruteforce). Très utile dès que SSH est exposé.
* **No-IP (DDNS)**: ton IP publique change souvent chez toi. No-IP met à jour un nom de domaine (ex: `monserveur.ddns.net`) vers ta nouvelle IP. La seule contrainte pour ce service est de se limiter à un nom de domaine et le renouveler tous les mois en répondant à une alerte mail.
* **Certbot (Let’s Encrypt)**: obtient et renouvelle automatiquement un certificat TLS. C’est ce qui permet HTTPS “propre” sans payer un certificat et sans manip manuelle.

---

## Vue globale du chemin réseau

1. Un navigateur demande `http(s)://monserveur.ddns.net`.
2. Le DNS (No-IP) renvoie ton IP publique actuelle.
3. La box (Livebox) reçoit la connexion et redirige le port 80/443 vers l’IP locale du serveur (NAT/PAT).
4. Le serveur (Apache) répond, en HTTP puis en HTTPS.
5. SSH est séparé: c’est l’accès administration (port 5823), protégé par clés + Fail2Ban + UFW.

---

# Étape 1 - Préparer la machine (Debian/RPi OS)

On part d’un système à jour. C’est la base de la sécurité: beaucoup d’attaques reposent sur des failles anciennes.

```bash
sudo apt update
sudo apt upgrade
```

Installe les composants:

```bash
sudo apt install apache2 ufw fail2ban openssh-server
```

```bash
sudo apt install certbot python3-certbot-apache
```

Pour servir du PHP:

```bash
sudo apt install php libapache2-mod-php
```

A ce stade, Apache tourne souvent déjà en local. On ne l’expose pas encore tant que le pare-feu et SSH ne sont pas propres. Bien entendu selon les besoins de l'application à déployer (Symfony-cli, git, MariaDB, PostgreSQL, Docker ...)  toute la pile logicielle devra être installée de manière adéquate. De plus la sécurité des utilisateurs du SGBD doit être correctement configurée et administrée.

---

# Étape 2 - Poser le cadre sécurité minimal (UFW)

On commence par une règle simple: “je ferme tout, puis j’ouvre uniquement ce dont j’ai besoin”.

Choix du port SSH: ici **5823** (autre que le port 22 utilisé nativement pour SSH).

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 5823/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

sudo ufw enable
sudo ufw status verbose
```

> **Important**  
> Ouvrir un port n’est pas anodin. Chaque port ouvert est une brèche potentielle dans la sécurité du système.

---

# Étape 3 - Configurer SSH proprement (admin à distance)

Objectif: pouvoir administrer la machine sans écran, mais sans offrir un "login + mot de passe” sur Internet.

## 3.1 Créer/valider l’utilisateur d’admin

On utilisera `user_bob` (qui aura sudo).

```bash
sudo adduser user_bob
sudo usermod -aG sudo user_bob
```

## 3.2 Configurer sshd

Edite:

```bash
sudo nano /etc/ssh/sshd_config
```

Paramètres à expliquer et mettre:

```text
Port 5823
PermitRootLogin no
PasswordAuthentication no
KbdInteractiveAuthentication no
PubkeyAuthentication yes
X11Forwarding no
AllowUsers user_bob
```

> **Important**  
> Si plusieurs comptes doivent accéder au serveur, on liste plusieurs utilisateurs ou on utilise `AllowGroups`.

Puis:

```bash
sudo sshd -t
sudo systemctl restart ssh
sudo ss -lntp | grep 5823
```

### Pourquoi ces réglages ?

* On évite `root` en direct: on passe par un utilisateur normal + sudo.
* On coupe l’authentification par mot de passe: c’est ce qui se brute-force le plus facilement.
* On restreint l’accès à un utilisateur connu (`user_bob`), ce qui réduit le bruit.
* Le port différent de 22 ne rend pas “invulnérable”, mais diminue le spam automatique.

---

## 3.3 Comprendre la paire de clés SSH (privée / publique)

Quand on exécute:

```bash
ssh-keygen -t ed25519
```

SSH crée **deux fichiers** (une paire de clés) dans `~/.ssh/` sur la machine cliente:

* `id_ed25519` : **clé privée**
  
  * Elle reste **strictement sur le poste client**.
  * Elle ne doit **jamais** être envoyée par mail/Discord/USB “en vrac”, ni copiée sur le serveur.
  * C’est l’équivalent d’une clé de coffre: si quelqu’un la récupère, il peut se faire passer pour toi.

* `id_ed25519.pub` : **clé publique**
  
  * Elle peut être partagée sans risque majeur.
  
  * C’est elle qu’on **dépose sur le serveur**, dans le compte utilisateur concerné, dans:
    
    * `/home/user_bob/.ssh/authorized_keys`
  
  * Le serveur “connaît” ainsi les clés autorisées à se connecter.

#### Pourquoi la connexion échoue si on ne dépose pas la clé publique ?

Quand on se connecte en SSH:

1. Le client prouve qu’il possède la **clé privée** (sans jamais l’envoyer).
2. Le serveur vérifie que la **clé publique correspondante** est présente dans `authorized_keys`.
3. Si la clé publique n’est pas là, le serveur ne peut pas valider l’identité -> **connexion refusée**.

C’est pour ça que **sans dépôt de la clé publique sur le serveur**, une connexion en mode “clés” ne peut pas fonctionner.

---

### Déposer la clé publique automatiquement (méthode simple)

Sur le PC du développeur/administrateur (client):

```bash
ssh-keygen -t ed25519
ssh-copy-id -p 5823 user_bob@monserveur.ddns.net
```

`ssh-copy-id`:

* se connecte au serveur,
* crée `~/.ssh/` si besoin,
* ajoute la clé publique dans `authorized_keys` proprement (sans écraser les autres).

> **Important**  
> `ssh-copy-id` ne peut déposer la clé publique que si une connexion est déjà possible (accès initial par mot de passe temporaire, ou accès local/console, etc.).
Sinon, il faut ajouter la clé publique manuellement depuis la console serveur.

Test:

```bash
ssh -p 5823 user_bob@monserveur.ddns.net
```

---

### Variante “manuelle” (si ssh-copy-id indisponible)

Afficher la clé publique sur le client:

```bash
cat ~/.ssh/id_ed25519.pub
```

Sur le serveur (depuis un compte sudo), déposer la clé dans le home de `user_bob`:

```bash
sudo mkdir -p /home/user_bob/.ssh
sudo chmod 700 /home/user_bob/.ssh
sudo nano /home/user_bob/.ssh/authorized_keys
sudo chmod 600 /home/user_bob/.ssh/authorized_keys
sudo chown -R user_bob:user_bob /home/user_bob/.ssh
```

---

# Étape 4 - Ajouter Fail2Ban (réaction automatique aux attaques)

Une fois SSH exposé, il faut accepter une réalité: le système sera scanné. Fail2Ban est un logiciel qui bannit automatiquement les IP agressives afin de limiter les prospections et intrusions.

On active et démarre Fail2Ban:

```bash
sudo systemctl enable --now fail2ban
```

On crée un fichier:

```bash
sudo nano /etc/fail2ban/jail.d/sshd.local
```

Contenu:

```ini
[sshd]
enabled = true
port = 5823
maxretry = 4
findtime = 10m
bantime = 1h
```

On redémarre:

```bash
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd
```

La sécurité ne peut pas reposer sur la simple utilisation d'un mot de passe fort.

---

# Étape 5 - No-IP et Livebox (rendre la machine joignable)

Cette étape se fait souvent en parallèle, mais il est mieux de la faire une fois SSH/UFW prêts.

## 5.1 No-IP (DDNS)

Créer un hostname (ex: `monserveur.ddns.net`) chez No-IP.
Soit:

* la box met à jour No-IP (selon modèle),
* soit on installe un client No-IP sur le serveur.

But: l’URL reste identique même si l’IP change.

## 5.2 Livebox (NAT/PAT)

Rediriger vers l’IP locale du serveur (ex: 192.168.1.24 sera par exemple l'ip du serveur sur le réseau local):

* TCP 80 -> 80
* TCP 443 -> 443
* TCP 5823 -> 5823

---

### Encadré - Comprendre NAT/PAT (box Internet)

Quand on héberge un serveur à la maison, la machine (Raspberry Pi ou Debian) n’est pas directement “sur Internet”. Elle se trouve derrière la box, dans un réseau privé (souvent en `192.168.x.x`). Or, Internet ne peut pas joindre une adresse privée.

#### NAT: une seule IP publique pour tout le réseau domestique

La box possède une **IP publique** (visible depuis Internet). Tous les appareils du réseau local partagent cette IP grâce au **NAT** (Network Address Translation).
Pour les connexions sortantes (navigation web, mises à jour, etc.), la box sait automatiquement quel appareil a initié la connexion et renvoie les réponses au bon endroit.

#### PAT: distinguer les services grâce aux ports

Pour les connexions entrantes (accès depuis Internet), la box ne peut pas deviner à quel appareil du réseau local elle doit transmettre la connexion.
Le **PAT** (Port Address Translation), souvent appelé “redirection de port”, sert à définir des règles du type:

* “Si une connexion arrive sur l’IP publique au port **80**, la transmettre vers **192.168.1.24:80** (HTTP)”
* “Si une connexion arrive au port **443**, la transmettre vers **192.168.1.24:443** (HTTPS)”
* “Si une connexion arrive au port **5823**, la transmettre vers **192.168.1.24:5823** (SSH)”

#### Une analogie simple

* IP publique de la box = l’adresse d’un immeuble
* ports = les numéros d’appartements
* redirection NAT/PAT = la règle qui indique à quel appartement livrer

#### Point de vigilance

Ouvrir/rediriger un port rend un service accessible depuis Internet.
Il est donc préférable de ne rediriger que les ports nécessaires et de sécuriser chaque service (pare-feu, clés SSH, fail2ban, mises à jour).

---

# Étape 6 - Organiser le site web (DocumentRoot propre)

Plutôt que tout mettre dans `/var/www/html`, on crée un dossier dédié au site.

Exemple:

```bash
sudo mkdir -p /var/www/monsite/public
sudo chown -R root:root /var/www/monsite
sudo chmod -R 755 /var/www/monsite
```

Page de test:

```bash
echo "<?php echo 'OK PHP';" | sudo tee /var/www/monsite/public/index.php
```

> **Important**  
> même si l'on voit souvent dans les tutos de développement l'utilisation de `phpinfo()`ou tout autre manipulation permettant de récolter des information et générer un texte plus gratifiant qu'un `Lorem Ipsum`cela expose aussi publiquement des informations sur le système qui pourraient un jour compromettre sa sécurité. Il est donc raisonnable de limiter toute information sur la machine et les logiciels installés dessus.

---

# Étape 7 - VirtualHost Apache (le site HTTP)

Créer:

```bash
sudo nano /etc/apache2/sites-available/monsite.conf
```

Contenu:

```apache
<VirtualHost *:80>
    ServerName monserveur.ddns.net
    DocumentRoot /var/www/monsite/public

    <Directory /var/www/monsite/public>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/monsite_error.log
    CustomLog ${APACHE_LOG_DIR}/monsite_access.log combined
</VirtualHost>
```

`AllowOverride All` est utile si l’application utilise .htaccess (ex: rewrite). Sinon, on peut le limiter.

Activer:

```bash
sudo a2ensite monsite.conf
sudo a2dissite 000-default.conf 2>/dev/null || true
sudo apache2ctl configtest
sudo systemctl reload apache2
```

Test local:

```bash
curl -I http://127.0.0.1/
```

---

### Encadré - Plusieurs sites sur un seul Apache (VirtualHosts)

Apache peut servir **plusieurs sites web** depuis une seule machine. Le mécanisme s’appelle les **VirtualHosts** (souvent abrégé en “vhosts”).

#### Le principe

Quand une requête arrive sur le serveur, elle contient un nom de domaine (en-tête HTTP `Host`). Apache compare ce nom aux VirtualHosts configurés et choisit celui qui correspond.

Un VirtualHost décrit essentiellement:

* **Quel nom de site** il gère (le domaine)
* **Où sont les fichiers** à servir sur le disque
* Quels réglages s’appliquent à ce site (logs, règles, HTTPS, etc.)

#### ServerName

`ServerName` indique le **nom de domaine principal** pris en charge par ce VirtualHost.
Exemples:

* `ServerName site1.example.net`
* `ServerName monserveur.ddns.net`

On peut aussi ajouter des alias avec `ServerAlias` (autres noms acceptés).

#### DocumentRoot

`DocumentRoot` indique le **répertoire racine** des fichiers servis par Apache pour ce site.
Exemples:

* `DocumentRoot /var/www/site1/public`
* `DocumentRoot /var/www/site2/public`

Cela permet d’héberger plusieurs sites sur la même machine en séparant clairement leurs dossiers.

#### Conséquence pratique

Deux sites différents peuvent partager la même IP et les mêmes ports (80/443), car Apache les distingue grâce à `ServerName` (le nom demandé) et sert les fichiers depuis le `DocumentRoot` associé.

#### Point de vigilance

Si aucune règle ne correspond (mauvais `ServerName`, requête faite par IP, ou vhost manquant), Apache sert le **site par défaut**. C’est souvent la raison pour laquelle on voit encore une “page Debian par défaut” après une configuration incomplète.

---

# Étape 8 - Passer en HTTPS avec Certbot

Quand HTTP marche, on passe à HTTPS.

```bash
sudo certbot --apache -d monserveur.ddns.net
```

Certbot:

* demande un mail
* accepte les CGU
* configure Apache pour 443
* installe le certificat Let’s Encrypt
* crée une config SSL et gère le renouvellement

> **Important**  
> Certbot doit pouvoir joindre le serveur depuis Internet sur le port 80 (challenge HTTP) au moment de la génération/renouvellement.

Test:

```bash
curl -Ik https://monserveur.ddns.net/
```

Renouvellement test:

```bash
sudo certbot renew --dry-run
```

---

# Étape 9 - Forcer HTTP -> HTTPS (une fois stable)

Quand HTTPS est OK, on redirige HTTP vers HTTPS:

```apache
<VirtualHost *:80>
    ServerName monserveur.ddns.net
    Redirect permanent / https://monserveur.ddns.net/
</VirtualHost>
```

Recharge:

```bash
sudo apache2ctl configtest
sudo systemctl reload apache2
```

---

# Étape 10 - Validation et habitudes de maintenance

Ce qu’on vérifie régulièrement:

* Ports réellement ouverts:

```bash
sudo ss -lntp
```

* Pare-feu:

```bash
sudo ufw status verbose
```

* Fail2Ban:

```bash
sudo fail2ban-client status sshd
```

* Certbot:

```bash
sudo certbot renew --dry-run
```

* Mises à jour:

```bash
sudo apt update
sudo apt upgrade
```

* sauvegarde du dossier /var/www/monsite

* sauvegarde de /etc/apache2

* sauvegarde des certificats Let’s Encrypt (/etc/letsencrypt)

* et si BDD: dump régulier

---

## Autohéberger chez soi: intérêt, limites, et points de vigilance

Mettre en place un serveur web autohébergé (Raspberry Pi ou Debian sur une machine domestique) est très utile: cela permet de reprendre la main sur l’infrastructure, de comprendre concrètement tout ce qui se passe entre Internet et le service (DNS, NAT/PAT, pare-feu, TLS, serveur web, mises à jour), et surtout de gagner en indépendance. Avec une connexion fibre moderne, il devient techniquement réaliste d’héberger des services légers (site vitrine, petit outil interne, démonstration de projet, API simple), sans avoir besoin d’un cloud.

En revanche, il ne faut pas sous-estimer les contraintes. Un serveur exposé est visible (scans, tentatives de connexion, bruit permanent sur les ports publics) et demande une hygiène de sécurité continue (mises à jour, durcissement, surveillance des logs). Les limites sont aussi matérielles et “domestiques”: le trafic montant (upload) est souvent bien plus faible que le descendant, la disponibilité dépend de la box, du réseau local, et de l’alimentation électrique (coupures, redémarrages), et il faut penser à la résilience (onduleur éventuel, redondance, plan de reprise). Enfin, l’autohébergement implique de gérer soi-même les sauvegardes et leur restauration: ce n’est pas “optionnel”, c’est une responsabilité centrale, car une panne de carte SD/SSD ou une mauvaise manipulation peut faire perdre un service entier.

Ce choix permet toutefois d’économiser des frais récurrents (hébergement mensuel, stockage, options “managed”, coûts qui augmentent avec le trafic ou le nombre de services) et de conserver un contrôle fin sur la pile technique (versions, modules, politique de logs, séparation des environnements). Surtout, il apporte une forme d’indépendance: les données restent sous contrôle direct, et l’infrastructure ne dépend pas d’un prestataire cloud parfois hors territoire, soumis à des cadres juridiques différents, et dont le poids contractuel peut être défavorable en cas de litige. L’autohébergement n’est donc pas seulement une solution technique: c’est un choix d’autonomie, à condition d’accepter la discipline opérationnelle qui va avec.
