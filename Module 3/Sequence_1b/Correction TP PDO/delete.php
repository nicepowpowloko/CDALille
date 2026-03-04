<?php
// delete.php
declare(strict_types=1);

require __DIR__ . '/db.php';

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

if (!$id || $id <= 0) {
  // ID invalide: on retourne à la liste
  redirect('index.php');
}

$stmt = $pdo->prepare('DELETE FROM post WHERE post_id = :id');
$stmt->execute([':id' => $id]);

redirect('index.php');
