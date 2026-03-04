#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# Projet MVC POO minimal (PHP) - scaffolding complet
# Usage:
#   chmod +x init_mvc.sh
#   ./init_mvc.sh mon_projet
# ------------------------------------------------------------

PROJECT_NAME="${1:-restaurant-mvc}"
ROOT_DIR="$(pwd)/${PROJECT_NAME}"

echo "Création du projet: ${ROOT_DIR}"

# 1) Dossiers
mkdir -p "${ROOT_DIR}"/{public/assets,app/{Controllers,Models,Views/{dish,partials},Core,Services},config,storage/{logs,cache},tests}

# 2) Fichiers
touch \
  "${ROOT_DIR}/.gitignore" \
  "${ROOT_DIR}/.env" \
  "${ROOT_DIR}/README.md" \
  "${ROOT_DIR}/public/index.php" \
  "${ROOT_DIR}/public/.htaccess" \
  "${ROOT_DIR}/public/assets/.keep" \
  "${ROOT_DIR}/app/Core/Autoloader.php" \
  "${ROOT_DIR}/app/Core/Router.php" \
  "${ROOT_DIR}/app/Core/Controller.php" \
  "${ROOT_DIR}/app/Core/Database.php" \
  "${ROOT_DIR}/app/Controllers/DishController.php" \
  "${ROOT_DIR}/app/Models/Category.php" \
  "${ROOT_DIR}/app/Models/Dish.php" \
  "${ROOT_DIR}/app/Services/DishValidator.php" \
  "${ROOT_DIR}/app/Views/dish/create.php" \
  "${ROOT_DIR}/app/Views/partials/header.php" \
  "${ROOT_DIR}/app/Views/partials/footer.php" \
  "${ROOT_DIR}/config/config.php"

# 3) Contenus de base

cat > "${ROOT_DIR}/.gitignore" <<'EOF'
/vendor/
.env
/storage/logs/*.log
/storage/cache/*
!.keep
EOF

cat > "${ROOT_DIR}/.env" <<'EOF'
# Remplace ces valeurs
DB_HOST=localhost
DB_NAME=restaurant_MVC
DB_USER=manwax
DB_PASS=change_me
DB_CHARSET=utf8mb4
EOF

cat > "${ROOT_DIR}/README.md" <<'EOF'
# Restaurant MVC POO (minimal)

## Lancer en local
Depuis la racine du projet:
- php -S localhost:8000 -t public

Puis ouvre:
- http://localhost:8000
EOF

cat > "${ROOT_DIR}/config/config.php" <<'EOF'
<?php
declare(strict_types=1);

return [
  'db' => [
    'host' => getenv('DB_HOST') ?: 'localhost',
    'name' => getenv('DB_NAME') ?: 'restaurant_MVC',
    'user' => getenv('DB_USER') ?: 'root',
    'pass' => getenv('DB_PASS') ?: '',
    'charset' => getenv('DB_CHARSET') ?: 'utf8mb4',
  ],
];
EOF

cat > "${ROOT_DIR}/app/Core/Autoloader.php" <<'EOF'
<?php
declare(strict_types=1);

namespace App\Core;

final class Autoloader
{
  public static function register(): void
  {
    spl_autoload_register(function (string $class): void {
      $prefix = 'App\\';
      $baseDir = dirname(__DIR__) . DIRECTORY_SEPARATOR;

      if (strpos($class, $prefix) !== 0) {
        return;
      }

      $relative = substr($class, strlen($prefix));
      $file = $baseDir . str_replace('\\', DIRECTORY_SEPARATOR, $relative) . '.php';

      if (is_file($file)) {
        require $file;
      }
    });
  }
}
EOF

cat > "${ROOT_DIR}/app/Core/Database.php" <<'EOF'
<?php
declare(strict_types=1);

namespace App\Core;

use PDO;
use PDOException;

final class Database
{
  private static ?PDO $pdo = null;

  public static function pdo(array $config): PDO
  {
    if (self::$pdo instanceof PDO) {
      return self::$pdo;
    }

    $db = $config['db'];
    $dsn = sprintf(
      'mysql:host=%s;dbname=%s;charset=%s',
      $db['host'],
      $db['name'],
      $db['charset']
    );

    try {
      self::$pdo = new PDO($dsn, $db['user'], $db['pass'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
      ]);
    } catch (PDOException $e) {
      throw new \RuntimeException('DB connexion failed: ' . $e->getMessage());
    }

    return self::$pdo;
  }
}
EOF

cat > "${ROOT_DIR}/app/Core/Controller.php" <<'EOF'
<?php
declare(strict_types=1);

namespace App\Core;

abstract class Controller
{
  protected function render(string $view, array $data = []): void
  {
    extract($data, EXTR_SKIP);

    $base = dirname(__DIR__) . '/Views/';
    $header = $base . 'partials/header.php';
    $footer = $base . 'partials/footer.php';
    $file = $base . $view . '.php';

    require $header;
    require $file;
    require $footer;
  }
}
EOF

cat > "${ROOT_DIR}/app/Core/Router.php" <<'EOF'
<?php
declare(strict_types=1);

namespace App\Core;

final class Router
{
  private array $routes = [
    'GET' => [],
    'POST' => [],
  ];

  public function get(string $path, callable $handler): void
  {
    $this->routes['GET'][$path] = $handler;
  }

  public function post(string $path, callable $handler): void
  {
    $this->routes['POST'][$path] = $handler;
  }

  public function dispatch(string $method, string $path): void
  {
    $handler = $this->routes[$method][$path] ?? null;

    if (!$handler) {
      http_response_code(404);
      echo "404 Not Found";
      return;
    }

    $handler();
  }
}
EOF

cat > "${ROOT_DIR}/app/Services/DishValidator.php" <<'EOF'
<?php
declare(strict_types=1);

namespace App\Services;

final class DishValidator
{
  public static function validate(array $input): array
  {
    $name = trim((string)($input['dishName'] ?? ''));
    $price = trim((string)($input['dishPrice'] ?? ''));
    $category = trim((string)($input['dishCategory'] ?? ''));

    if ($name === '' || $price === '' || $category === '') {
      throw new \InvalidArgumentException('Tous les champs sont obligatoires.');
    }

    if (!is_numeric($price) || (float)$price <= 0) {
      throw new \InvalidArgumentException('Le prix doit être un nombre positif.');
    }

    if (!ctype_digit($category)) {
      throw new \InvalidArgumentException('Catégorie invalide.');
    }

    return [
      'name' => $name,
      'price' => (float)$price,
      'category' => (int)$category,
    ];
  }
}
EOF

cat > "${ROOT_DIR}/app/Models/Category.php" <<'EOF'
<?php
declare(strict_types=1);

namespace App\Models;

use PDO;

final class Category
{
  public static function all(PDO $pdo): array
  {
    $sql = "SELECT id_categorie, nom_categorie FROM categorie ORDER BY nom_categorie";
    return $pdo->query($sql)->fetchAll();
  }
}
EOF

cat > "${ROOT_DIR}/app/Models/Dish.php" <<'EOF'
<?php
declare(strict_types=1);

namespace App\Models;

use PDO;

final class Dish
{
  public static function create(PDO $pdo, string $name, int $categoryId, float $price): void
  {
    $stmt = $pdo->prepare("INSERT INTO plat (nom_plat, id_categorie, prix) VALUES (:name, :cat, :price)");
    $stmt->execute([
      ':name' => $name,
      ':cat' => $categoryId,
      ':price' => $price,
    ]);
  }
}
EOF

cat > "${ROOT_DIR}/app/Controllers/DishController.php" <<'EOF'
<?php
declare(strict_types=1);

namespace App\Controllers;

use App\Core\Controller;
use App\Core\Database;
use App\Models\Category;
use App\Models\Dish;
use App\Services\DishValidator;

final class DishController extends Controller
{
  private array $config;

  public function __construct(array $config)
  {
    $this->config = $config;
  }

  public function createForm(): void
  {
    $pdo = Database::pdo($this->config);
    $categories = Category::all($pdo);

    $this->render('dish/create', [
      'categories' => $categories,
      'successMessage' => '',
      'errorMessage' => '',
    ]);
  }

  public function store(): void
  {
    $successMessage = '';
    $errorMessage = '';

    try {
      $pdo = Database::pdo($this->config);
      $categories = Category::all($pdo);

      $data = DishValidator::validate($_POST);
      Dish::create($pdo, $data['name'], $data['category'], $data['price']);

      $successMessage = 'Nouveau plat ajouté avec succès!';
    } catch (\Throwable $e) {
      $errorMessage = 'Erreur: ' . $e->getMessage();
      $pdo = Database::pdo($this->config);
      $categories = Category::all($pdo);
    }

    $this->render('dish/create', compact('categories', 'successMessage', 'errorMessage'));
  }
}
EOF

cat > "${ROOT_DIR}/app/Views/partials/header.php" <<'EOF'
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Restaurant - MVC</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
EOF

cat > "${ROOT_DIR}/app/Views/partials/footer.php" <<'EOF'
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
EOF

cat > "${ROOT_DIR}/app/Views/dish/create.php" <<'EOF'
<h2>Ajouter un nouveau plat</h2>

<?php if (!empty($successMessage)): ?>
  <div class="alert alert-success"><?= htmlspecialchars($successMessage) ?></div>
<?php elseif (!empty($errorMessage)): ?>
  <div class="alert alert-danger"><?= htmlspecialchars($errorMessage) ?></div>
<?php endif; ?>

<form method="POST" action="/dish/store" onsubmit="return validateForm()">
  <div class="mb-3">
    <label for="dishName" class="form-label">Nom du plat</label>
    <input type="text" class="form-control" id="dishName" name="dishName" required>
  </div>

  <div class="mb-3">
    <label for="dishPrice" class="form-label">Prix du plat (€)</label>
    <input type="number" step="0.01" class="form-control" id="dishPrice" name="dishPrice" required>
  </div>

  <div class="mb-3">
    <label for="dishCategory" class="form-label">Catégorie</label>
    <select class="form-control" id="dishCategory" name="dishCategory" required>
      <option value="">Sélectionner une catégorie</option>
      <?php foreach (($categories ?? []) as $category): ?>
        <option value="<?= (int)$category['id_categorie'] ?>">
          <?= htmlspecialchars($category['nom_categorie']) ?>
        </option>
      <?php endforeach; ?>
    </select>
  </div>

  <button type="submit" class="btn btn-primary">Ajouter le plat</button>
</form>

<script>
function validateForm() {
  const name = document.getElementById('dishName').value;
  const price = document.getElementById('dishPrice').value;
  const category = document.getElementById('dishCategory').value;

  if (name.trim() === '' || String(price).trim() === '' || category === '') {
    alert('Tous les champs doivent être remplis.');
    return false;
  }
  if (parseFloat(price) <= 0) {
    alert('Le prix doit être un nombre positif.');
    return false;
  }
  return true;
}
</script>
EOF

cat > "${ROOT_DIR}/public/.htaccess" <<'EOF'
RewriteEngine On

# Si le fichier ou dossier existe, on sert directement
RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^ - [L]

# Sinon, tout passe par index.php
RewriteRule ^ index.php [QSA,L]
EOF

cat > "${ROOT_DIR}/public/index.php" <<'EOF'
<?php
declare(strict_types=1);

use App\Core\Autoloader;
use App\Core\Router;
use App\Controllers\DishController;

// Charge .env (sans lib externe, version très simple)
$envFile = dirname(__DIR__) . '/.env';
if (is_file($envFile)) {
  foreach (file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
    if (str_starts_with(trim($line), '#')) continue;
    if (!str_contains($line, '=')) continue;
    [$k, $v] = array_map('trim', explode('=', $line, 2));
    if ($k !== '' && getenv($k) === false) {
      putenv("$k=$v");
    }
  }
}

require dirname(__DIR__) . '/app/Core/Autoloader.php';
Autoloader::register();

$config = require dirname(__DIR__) . '/config/config.php';

$router = new Router();
$controller = new DishController($config);

$router->get('/', fn() => $controller->createForm());
$router->get('/dish/create', fn() => $controller->createForm());
$router->post('/dish/store', fn() => $controller->store());

$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
$path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';

$router->dispatch($method, $path);
EOF

echo
echo "OK. Projet créé."
echo "Prochaines étapes:"
echo "1) Édite ${ROOT_DIR}/.env (DB_PASS notamment)"
echo "2) Lance: cd \"${ROOT_DIR}\" && php -S localhost:8000 -t public"
echo "3) Ouvre: http://localhost:8000"

