# Checklist DEV → PROD (Symfony 7.4)

Ce document décrit l’ensemble des actions nécessaires et des points de vigilance lors du passage d’un projet Symfony 7.4 de l’environnement de développement vers un environnement de production.
L’objectif est d’éviter les différences de comportement, les erreurs invisibles et les régressions fonctionnelles.

---

## 1. Environnement Symfony

### Variables d’environnement

En production, l’application doit fonctionner dans un environnement strict et optimisé.

```env
APP_ENV=prod
APP_DEBUG=0
```

* `APP_ENV=prod` active les optimisations spécifiques à la production.
* `APP_DEBUG=0` désactive l’affichage des erreurs techniques et des stack traces.

En développement, Symfony affiche volontairement beaucoup d’informations. En production, **aucune information technique ne doit être exposée**.

Après toute modification des variables d’environnement, le cache doit être vidé explicitement :

```bash
php bin/console cache:clear --env=prod
```

---

## 2. Cache et compilation

### Cache Symfony

En production, Symfony ne reconstruit pas son cache automatiquement.
Tout ce qui dépend de la configuration, des routes, des services ou du conteneur doit être préparé à l’avance.

```bash
php bin/console cache:clear --env=prod
php bin/console cache:warmup --env=prod
```

* `cache:clear` supprime l’ancien cache
* `cache:warmup` génère le cache final utilisé par l’application

Sans cette étape, des comportements incohérents ou des erreurs silencieuses peuvent apparaître.

---

## 3. Assets (CSS / JS)

### Cas AssetMapper (solution par défaut Symfony 7)

Symfony 7 utilise par défaut **AssetMapper**, qui applique un versioning des fichiers (hash dans le nom) afin de gérer correctement le cache navigateur.

En production, les assets doivent être compilés manuellement :

```bash
php bin/console asset-map:compile
```

Cette commande :

* copie les fichiers dans `public/assets`
* génère des noms de fichiers hashés
* crée un fichier `manifest.json`

Vérification attendue :

```bash
ls public/assets
```

On doit y trouver :

* des fichiers CSS/JS avec hash
* un fichier `manifest.json`

---

### Règle fondamentale d’inclusion des assets

Les assets doivent toujours être référencés via Twig :

```twig
<link rel="stylesheet" href="{{ asset('styles/app.css') }}">
```

Il ne faut **jamais** référencer un fichier en dur :

```html
<link rel="stylesheet" href="/styles/app.css">
```

En production, ce fichier n’existe plus sous ce nom.

---

### Cas Webpack Encore

Si Webpack Encore est utilisé :

```bash
npm install
npm run build
```

Dans Twig :

```twig
{{ encore_entry_link_tags('app') }}
{{ encore_entry_script_tags('app') }}
```

Le principe est identique : les fichiers sont versionnés et lus via un manifeste.

---

## 4. Sécurité (point critique)

### Gestion des erreurs 403 en Symfony 7.4

En Symfony 7.4, les refus d’accès liés à la sécurité **ne passent pas automatiquement** par `error403.html.twig`.

Un simple template ne suffit pas.

Pour personnaliser une 403 liée aux rôles ou aux permissions, on doit :

1. Créer un `AccessDeniedHandler`
2. Le déclarer explicitement dans `security.yaml`

```yaml
security:
    firewalls:
        main:
            access_denied_handler: App\Security\AccessDeniedHandler
```

Sans cette configuration :

* Symfony affichera sa page 403 générique
* même en environnement de production

---

### Vérification des firewalls

Il est nécessaire de vérifier :

* si le firewall est `stateless` ou non
* la configuration de `form_login`
* les règles `access_control`

Les tests doivent être réalisés avec :

* un utilisateur non authentifié
* un utilisateur authentifié sans le bon rôle
* un utilisateur disposant des droits requis

---

## 5. Pages d’erreur applicatives

Au minimum, les pages suivantes doivent être définies :

```
templates/bundles/TwigBundle/Exception/
├── error404.html.twig
├── error500.html.twig
```

Ces templates couvrent la majorité des erreurs applicatives.

Les erreurs 403 liées à la sécurité sont gérées via le `AccessDeniedHandler`, et non via TwigBundle.

---

## 6. Logs

En production, aucune erreur ne doit être affichée à l’écran.
Toutes les erreurs doivent être consultables via les logs.

Emplacement principal :

```
var/log/prod.log
```

Les permissions doivent permettre l’écriture par le serveur web :

```bash
chown -R www-data:www-data var/
```

Un problème en production sans logs exploitables est très difficile à diagnostiquer.

---

## 7. Base de données

### Migrations

Les changements de schéma doivent être appliqués exclusivement via des migrations :

```bash
php bin/console doctrine:migrations:migrate --env=prod
```

Il ne faut **jamais** utiliser :

```bash
doctrine:schema:update --force
```

en production, car cela contourne le versioning du schéma.

---

### Données sensibles

Points de contrôle :

* mots de passe correctement hashés
* absence de fixtures de développement
* comptes administrateurs clairement identifiés

---

## 8. Serveur web (fondamental)

### DocumentRoot

Le serveur web doit pointer exclusivement vers le dossier `public` :

```
/var/www/mon-projet/public
```

Ne jamais exposer la racine du projet, sous peine de :

* fuites de fichiers sensibles
* erreurs 403/404 serveur
* comportements incohérents

---

### Permissions

Les dossiers suivants doivent être accessibles en écriture :

```bash
chown -R www-data:www-data var/ public/
```

---

## 9. HTTPS et cookies

En production, l’application doit fonctionner sous HTTPS.

Configuration recommandée :

```yaml
framework:
    session:
        cookie_secure: auto
        cookie_samesite: lax
```

Cela garantit :

* la sécurité des cookies de session
* la compatibilité avec les navigateurs modernes

---

## 10. Emails, API et services externes

Il est indispensable de séparer :

* les clés API de développement et de production
* les serveurs SMTP
* les webhooks et endpoints externes

Les variables sensibles doivent être stockées :

* dans `.env.local`
* ou directement dans l’environnement serveur

---

## 11. Nettoyage final du code

Avant mise en production, il faut supprimer :

* appels à `dump()`, `dd()`, `var_dump()`
* routes de test
* contrôleurs temporaires
* comptes utilisateurs fictifs

---

## 12. Tests manuels avant ouverture

Une vérification fonctionnelle complète doit être réalisée :

* authentification
* déconnexion
* accès interdit avec page 403 personnalisée
* page 404 correcte
* chargement du CSS
* chargement du JavaScript
* formulaire valide
* formulaire invalide
* rechargement navigateur (gestion du cache)

---

## 13. Commandes finales recommandées

Les commandes suivantes peuvent être exécutées dans cet ordre :

```bash
composer install --no-dev --optimize-autoloader
php bin/console cache:clear --env=prod
php bin/console cache:warmup --env=prod
php bin/console asset-map:compile
php bin/console doctrine:migrations:migrate --env=prod
```

---

## Synthèse des erreurs fréquentes DEV → PROD

| Problème observé       | Cause probable                         |
| ---------------------- | -------------------------------------- |
| CSS non chargé         | assets non compilés                    |
| 403 générique          | absence de AccessDeniedHandler         |
| Page blanche           | erreur non loguée avec debug désactivé |
| 404 serveur            | DocumentRoot incorrect                 |
| Comportement différent | cache de production non reconstruit    |

---

### Conclusion

Le passage en production ne consiste pas à “désactiver le debug”, mais à **figer, compiler et sécuriser** l’application.
Une application Symfony correctement préparée en production est plus rapide, plus stable et plus sûre.
