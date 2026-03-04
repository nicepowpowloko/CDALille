<?php
// Modern.php

declare(strict_types=1);

$visitorName = 'Invité';
$currentDate = date('d/m/Y');

$tasks = [
    'Préparer le café',
    'Lire les mails',
    'Nourrir le chat',
];

function escape(string $value): string {
    return htmlspecialchars($value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de bord</title>
</head>
<body>
    <h1>Tableau de bord</h1>

    <p>
        Bonjour <?= escape($visitorName) ?> !
        Nous sommes le <?= escape($currentDate) ?>.
    </p>

    <ul>
        <?php foreach ($tasks as $task): ?>
            <li><?= escape($task) ?></li>
        <?php endforeach; ?>
    </ul>

    <button type="button" id="show-message">Afficher un message</button>

    <p id="message" hidden>Bon travail, continue comme ça !</p>

    <script type="module">
        const button = document.querySelector('#show-message');
        const message = document.querySelector('#message');

        button.addEventListener('click', () => {
            message.hidden = false;
        });
    </script>
</body>
</html>

