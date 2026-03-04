<?php
// index.php
declare(strict_types=1);

require __DIR__ . '/db.php';

$stmt = $pdo->prepare(
    'SELECT post_id, post_title, post_author, post_created_at
   FROM post
   ORDER BY post_created_at DESC'
);
$stmt->execute();
$posts = $stmt->fetchAll();
?>
<!doctype html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <title>Mini blog - Liste</title>
</head>

<body>
    <h1>Mini blog</h1>

    <p><a href="create.php">Ajouter un article</a></p>

    <?php if (count($posts) === 0): ?>
        <p>Aucun article pour le moment.</p>
    <?php else: ?>
        <table border="1" cellpadding="6" cellspacing="0">
            <thead>
                <tr>
                    <th>Titre</th>
                    <th>Auteur</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($posts as $post): ?>
                    <tr>
                        <td><?= h($post['post_title']) ?></td>
                        <td><?= h($post['post_author']) ?></td>
                        <td><?= h($post['post_created_at']) ?></td>
                        <td>
                            <a
                                href="delete.php?id=<?= (int)$post['post_id'] ?>"
                                onclick="return confirm('Supprimer cet article ?');">
                                Supprimer
                            </a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</body>

</html>