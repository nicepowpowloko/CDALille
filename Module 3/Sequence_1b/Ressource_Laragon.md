<img src="../../Logo.png" width="550" height="75" alt="logo">

# Installer Laragon pour PHP + MariaDB sous Windows 10/11

## Objectif

Installer un environnement de développement local permettant d’exécuter :

- PHP
- Apache
- MariaDB
- phpMyAdmin / HeidiSQL

Le tout **sans configuration complexe**, pour travailler sur PHP + MariaDB

---

## 1. Télécharger Laragon

1. Ouvrir un navigateur
2. Aller sur : [le site de Laragon](https://laragon.org/download/)
3. Télécharger **Laragon – Full (64 bits)**  
   (compatible Windows 10 et 11)

---

## 2. Installer Laragon

1. Lancer le fichier téléchargé (`laragon-wamp.exe`)

2. Cliquer sur **Next** à chaque étape

3. Laisser le dossier par défaut :

```batch
   C:\laragon
```

4. Valider l’installation

!!! Ne pas installer dans `Program Files` !!!

---

## 3. Démarrer Laragon

1. Lancer **Laragon** depuis le menu Démarrer
2. Cliquer sur le bouton **Start All**

Si tout est correct :

- Apache : vert
- MariaDB : vert

---

## 4. Vérifier que PHP fonctionne

1. Ouvrir un navigateur

2. Aller sur :

```batch
   http://localhost/
```

Tu dois voir la page d’accueil Laragon.

---

## 5. Créer un projet PHP

1. Aller dans le dossier :

```batch
   C:\laragon\www
```

2. Créer un dossier :

   ```txt
   blog
   ```

3. Dans ce dossier, créer un fichier `index.php`

4. Mettre ce code dedans :

```php
<?php
echo "Laragon fonctionne !";
```

5. Aller sur :

```batch
http://localhost/blog/
```

Si le message s’affiche, **PHP est opérationnel**.

---

## 6. Accéder à la base de données (MariaDB)

### Option 1 : HeidiSQL (recommandé)

1. Dans Laragon, cliquer sur **Database**
2. HeidiSQL s’ouvre automatiquement
3. Mot de passe par défaut :
   - utilisateur : `root`
   - mot de passe : *(vide)*

### Option 2 : phpMyAdmin

- Aller sur :

```url
http://localhost/phpmyadmin
```

---

## 7. Créer la base de données du TP

Dans HeidiSQL ou phpMyAdmin :

```sql
CREATE DATABASE blog CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE blog;
```

Puis importer le script SQL fourni dans le TP.

---

## 8. Connexion PDO (exemple)

Créer un fichier `db.php` :

```php
<?php

$dsn = "mysql:host=localhost;dbname=blog;charset=utf8mb4";
$user = "root";
$pass = "";

try {
    $pdo = new PDO($dsn, $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erreur connexion BDD : " . $e->getMessage());
}
```

---

## 9. Points importants à retenir

- Tous les projets PHP vont dans :
  
  ```batch
  C:\laragon\www
  ```

- URL locale :
  
  ```url
  http://localhost/nom_du_dossier/
  ```

- MariaDB est déjà installé et configuré

- Aucun mot de passe par défaut pour `root`

---

## 10. Problèmes fréquents

- Page blanche → erreur PHP (activer affichage erreurs)
- Apache ne démarre pas → fermer Skype / IIS
- Mauvais dossier → vérifier `www`
