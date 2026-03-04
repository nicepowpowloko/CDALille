param(
    [string]$ProjectName = "restaurant-mvc"
)

$RootDir = Join-Path (Get-Location) $ProjectName

Write-Host "Création du projet : $RootDir"

# ------------------------------------------------------------
# 1) Dossiers
# ------------------------------------------------------------
$directories = @(
    "public/assets",
    "app/Controllers",
    "app/Models",
    "app/Views/dish",
    "app/Views/partials",
    "app/Core",
    "app/Services",
    "config",
    "storage/logs",
    "storage/cache",
    "tests"
)

foreach ($dir in $directories) {
    New-Item -ItemType Directory -Path (Join-Path $RootDir $dir) -Force | Out-Null
}

# ------------------------------------------------------------
# 2) Fichiers vides
# ------------------------------------------------------------
$files = @(
    ".gitignore",
    ".env",
    "README.md",
    "public/index.php",
    "public/.htaccess",
    "public/assets/.keep",
    "app/Core/Autoloader.php",
    "app/Core/Router.php",
    "app/Core/Controller.php",
    "app/Core/Database.php",
    "app/Controllers/DishController.php",
    "app/Models/Category.php",
    "app/Models/Dish.php",
    "app/Services/DishValidator.php",
    "app/Views/dish/create.php",
    "app/Views/partials/header.php",
    "app/Views/partials/footer.php",
    "config/config.php"
)

foreach ($file in $files) {
    New-Item -ItemType File -Path (Join-Path $RootDir $file) -Force | Out-Null
}

# ------------------------------------------------------------
# 3) Contenus
# ------------------------------------------------------------

@"
/vendor/
.env
/storage/logs/*.log
/storage/cache/*
!.keep
"@ | Set-Content "$RootDir/.gitignore"

@"
DB_HOST=localhost
DB_NAME=restaurant
DB_USER=manwax
DB_PASS=change_me
DB_CHARSET=utf8mb4
"@ | Set-Content "$RootDir/.env"

@"
# Restaurant MVC POO (minimal)

## Lancer en local
php -S localhost:8000 -t public
"@ | Set-Content "$RootDir/README.md"

@"
<?php
declare(strict_types=1);

return [
  'db' => [
    'host' => getenv('DB_HOST') ?: 'localhost',
    'name' => getenv('DB_NAME') ?: 'restaurant',
    'user' => getenv('DB_USER') ?: 'root',
    'pass' => getenv('DB_PASS') ?: '',
    'charset' => getenv('DB_CHARSET') ?: 'utf8mb4',
  ],
];
"@ | Set-Content "$RootDir/config/config.php"

@"
<?php
declare(strict_types=1);

namespace App\Core;

final class Autoloader
{
  public static function register(): void
  {
    spl_autoload_register(function (string \$class): void {
      \$prefix = 'App\\\\';
      \$baseDir = dirname(__DIR__) . DIRECTORY_SEPARATOR;

      if (strpos(\$class, \$prefix) !== 0) return;

      \$relative = substr(\$class, strlen(\$prefix));
      \$file = \$baseDir . str_replace('\\\\', DIRECTORY_SEPARATOR, \$relative) . '.php';

      if (is_file(\$file)) require \$file;
    });
  }
}
"@ | Set-Content "$RootDir/app/Core/Autoloader.php"

@"
<?php
declare(strict_types=1);

namespace App\Core;

use PDO;

final class Database
{
  private static ?PDO \$pdo = null;

  public static function pdo(array \$config): PDO
  {
    if (self::\$pdo) return self::\$pdo;

    \$db = \$config['db'];
    \$dsn = \"mysql:host={\$db['host']};dbname={\$db['name']};charset={\$db['charset']}\";

    self::\$pdo = new PDO(\$dsn, \$db['user'], \$db['pass'], [
      PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
      PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);

    return self::\$pdo;
  }
}
"@ | Set-Content "$RootDir/app/Core/Database.php"

@"
<?php
declare(strict_types=1);

namespace App\Core;

abstract class Controller
{
  protected function render(string \$view, array \$data = []): void
  {
    extract(\$data);
    \$base = dirname(__DIR__) . '/Views/';
    require \$base . 'partials/header.php';
    require \$base . \$view . '.php';
    require \$base . 'partials/footer.php';
  }
}
"@ | Set-Content "$RootDir/app/Core/Controller.php"

@"
<?php
declare(strict_types=1);

namespace App\Core;

final class Router
{
  private array \$routes = ['GET'=>[], 'POST'=>[]];

  public function get(string \$path, callable \$h): void { \$this->routes['GET'][\$path] = \$h; }
  public function post(string \$path, callable \$h): void { \$this->routes['POST'][\$path] = \$h; }

  public function dispatch(string \$method, string \$path): void
  {
    \$handler = \$this->routes[\$method][\$path] ?? null;
    if (!\$handler) { http_response_code(404); echo '404'; return; }
    \$handler();
  }
}
"@ | Set-Content "$RootDir/app/Core/Router.php"

@"
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^ - [L]
RewriteRule ^ index.php [QSA,L]
"@ | Set-Content "$RootDir/public/.htaccess"

Write-Host ""
Write-Host "✅ Projet créé avec succès"
Write-Host "➡ cd $RootDir"
Write-Host "➡ php -S localhost:8000 -t public"
Write-Host "➡ http://localhost:8000"
