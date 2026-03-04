# Annexe - Durcissement et fiabilisation du serveur Raspberry Pi (manpi.ddns.net)

## Constat initial

* Un incident d’inaccessibilité a été résolu par reboot physique.
* Aucun journal du boot précédent n’était disponible (`journald` non persistant).
* Aucun client DDNS n’est présent sur le Pi (pas de `noip2`, `ddclient`, `inadyn`, ni cron).
* Le Pi est connecté en Wi-Fi (`wlan0`), ce qui augmente le risque de décrochages.
* Le domaine renvoie une IPv4 tandis que la machine voit surtout une IPv6 publique (ex: `2a01:...`), ce qui renforce le besoin d’un DDNS fiable.

---

## 1) Activer les journaux persistants (diagnostic post-incident)

Objectif: pouvoir lire les erreurs du boot précédent après un redémarrage.

### Création du stockage persistant pour journald

```bash
sudo mkdir -p /var/log/journal
sudo systemd-tmpfiles --create --prefix /var/log/journal
sudo systemctl restart systemd-journald
```

### Vérification

```bash
journalctl --disk-usage
ls -ld /var/log/journal
```

### Optionnel: limiter la taille et la rétention

Modifier:

```bash
sudo nano /etc/systemd/journald.conf
```

Exemple de paramètres:

```
Storage=persistent
SystemMaxUse=300M
RuntimeMaxUse=50M
MaxRetentionSec=1month
```

Puis:

```bash
sudo systemctl restart systemd-journald
```

### Lecture des logs du boot précédent (après incident)

```bash
sudo journalctl -b -1 -p err..alert --no-pager
sudo journalctl -b -1 -k --no-pager
```

---

## 2) Mettre en place un redémarrage automatique en cas de freeze (watchdog)

Objectif: éviter qu’un blocage impose un reboot manuel (utile quand tu es au travail).

### Installation + activation

```bash
sudo apt update
sudo apt install watchdog
sudo systemctl enable --now watchdog
sudo systemctl status watchdog --no-pager
```

---

## 3) Auto-relance des services critiques (systemd)

Objectif: si un service (Apache, etc.) tombe, il redémarre automatiquement.

### Exemple (Apache ou autre service)

```bash
sudo systemctl edit apache2
```

Ajouter:

```
[Service]
Restart=always
RestartSec=3
```

Appliquer:

```bash
sudo systemctl daemon-reload
sudo systemctl restart apache2
```

---

## 4) Script de “self-heal” du Web (optionnel)

Objectif: redémarrer Apache si l’HTTPS local ne répond plus.

### Script

```bash
sudo nano /usr/local/sbin/selfheal-web.sh
```

Contenu:

```bash
#!/bin/bash
set -e
if ! curl -fsS --max-time 5 https://localhost/ >/dev/null 2>&1; then
  systemctl restart apache2
fi
```

Activation:

```bash
sudo chmod +x /usr/local/sbin/selfheal-web.sh
```

### Service + timer systemd (toutes les 2 minutes)

Créer:

```bash
sudo nano /etc/systemd/system/selfheal-web.service
```

```
[Unit]
Description=Self-heal web stack

[Service]
Type=oneshot
ExecStart=/usr/local/sbin/selfheal-web.sh
```

Créer:

```bash
sudo nano /etc/systemd/system/selfheal-web.timer
```

```
[Unit]
Description=Run self-heal web check

[Timer]
OnBootSec=2min
OnUnitActiveSec=2min
AccuracySec=30s

[Install]
WantedBy=timers.target
```

Activer:

```bash
sudo systemctl enable --now selfheal-web.timer
systemctl list-timers | grep selfheal
```

---

## 5) Fiabiliser la connectivité Wi-Fi (si Ethernet impossible)

Objectif: corriger automatiquement une perte de connectivité Wi-Fi, sans reboot.

### Script Wi-Fi “heal”

```bash
sudo nano /usr/local/sbin/wifi-heal.sh
```

Contenu:

```bash
#!/bin/bash
set -e

# Test vers la box (LAN)
if ! ping -c 1 -W 2 192.168.1.1 >/dev/null 2>&1; then
  /sbin/ip link set wlan0 down || true
  sleep 2
  /sbin/ip link set wlan0 up || true
  exit 0
fi

# Test vers Internet (WAN)
if ! ping -c 1 -W 3 1.1.1.1 >/dev/null 2>&1; then
  /sbin/ip link set wlan0 down || true
  sleep 2
  /sbin/ip link set wlan0 up || true
fi
```

Activation:

```bash
sudo chmod +x /usr/local/sbin/wifi-heal.sh
```

### Service + timer (toutes les 1 minute)

Créer:

```bash
sudo nano /etc/systemd/system/wifi-heal.service
```

```
[Unit]
Description=Heal WiFi if connectivity is lost

[Service]
Type=oneshot
ExecStart=/usr/local/sbin/wifi-heal.sh
```

Créer:

```bash
sudo nano /etc/systemd/system/wifi-heal.timer
```

```
[Unit]
Description=Run WiFi heal periodically

[Timer]
OnBootSec=1min
OnUnitActiveSec=1min
AccuracySec=20s

[Install]
WantedBy=timers.target
```

Activer:

```bash
sudo systemctl enable --now wifi-heal.timer
systemctl list-timers | grep wifi-heal
```

Note: l’option la plus fiable reste le passage en Ethernet (ou CPL de qualité) si possible.

---

## 6) Reprendre le contrôle du DDNS sur le Pi (au lieu de la box)

Objectif: éviter une mise à jour DDNS opaque et dépendante de la Livebox.

### Installer `ddclient` pour No-IP

```bash
sudo apt update
sudo apt install ddclient
sudo systemctl enable --now ddclient
sudo systemctl status ddclient --no-pager
```

### Vérifier la mise à jour DDNS

```bash
sudo tail -n 50 /var/log/syslog | grep ddclient
```

---

## 7) Commandes de contrôle “état serveur”

Objectif: diagnostic rapide en cas de doute.

```bash
systemctl is-system-running
systemctl --failed
sudo ss -tulpn | egrep ':80|:443'
sudo systemctl status apache2 --no-pager
df -h
free -h
vcgencmd get_throttled
```

---

## Résultat attendu

* Les pannes seront traçables (logs persistants).
* Les freezes seront gérés automatiquement (watchdog).
* Les services critiques se relanceront sans action manuelle.
* La connectivité Wi-Fi sera auto-réparée (si maintien du Wi-Fi).
* Le DDNS sera mis à jour par le Pi (plus fiable et contrôlable).

