<?php
// db.php
declare(strict_types=1);

// Ajuste ces valeurs selon ton environnement
$dsn  = 'mysql:host=localhost;dbname=blog;charset=utf8mb4';
$user = 'dev';
$pass = 'plouf';

$options = [
  PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
  PDO::ATTR_EMULATE_PREPARES   => false, // mieux si supporté
];

try {
  $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
  // En TP: message simple. En prod: ne jamais afficher l'erreur brute.
  http_response_code(500);
  echo "Erreur de connexion à la base de données.";
  exit;
}

/**
 * Échappement HTML (anti XSS sur l'affichage).
 */
function h(?string $value): string
{
  return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
}

/**
 * Redirection simple.
 */
function redirect(string $to): void
{
  header('Location: ' . $to);
  exit;
}
