<?php
// create.php
declare(strict_types=1);

require __DIR__ . '/db.php';

$errors = [];
$title  = '';
$content = '';
$author = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $title   = trim((string)($_POST['title'] ?? ''));
  $content = trim((string)($_POST['content'] ?? ''));
  $author  = trim((string)($_POST['author'] ?? ''));

  if ($title === '')   $errors[] = "Le titre est obligatoire.";
  if ($content === '') $errors[] = "Le contenu est obligatoire.";
  if ($author === '')  $errors[] = "L'auteur est obligatoire.";

  if (!$errors) {
    $stmt = $pdo->prepare(
      'INSERT INTO post (post_title, post_content, post_author)
       VALUES (:title, :content, :author)'
    );
    $stmt->execute([
      ':title'   => $title,
      ':content' => $content,
      ':author'  => $author,
    ]);

    redirect('index.php');
  }
}
?>
<!doctype html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>Mini blog - Ajouter</title>
</head>
<body>
  <h1>Ajouter un article</h1>

  <p><a href="index.php">Retour à la liste</a></p>

  <?php if ($errors): ?>
    <div>
      <p><strong>Erreurs :</strong></p>
      <ul>
        <?php foreach ($errors as $err): ?>
          <li><?= h($err) ?></li>
        <?php endforeach; ?>
      </ul>
    </div>
  <?php endif; ?>

  <form method="post" action="create.php">
    <div>
      <label for="title">Titre</label><br>
      <input type="text" id="title" name="title" maxlength="255" value="<?= h($title) ?>" required>
    </div>

    <div>
      <label for="content">Contenu</label><br>
      <textarea id="content" name="content" rows="8" cols="60" required><?= h($content) ?></textarea>
    </div>

    <div>
      <label for="author">Auteur</label><br>
      <input type="text" id="author" name="author" maxlength="100" value="<?= h($author) ?>" required>
    </div>

    <div>
      <button type="submit">Enregistrer</button>
    </div>
  </form>
</body>
</html>
