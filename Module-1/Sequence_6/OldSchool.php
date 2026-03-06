<?php
// OldSchool.php

// ======================================================================
//  Initialisation des variables
// ======================================================================
$nomUtilisateur = "Invité";
$dateCourante   = date('d/m/Y');

// ======================================================================
//  Définition de la liste des tâches
// ======================================================================
$taches = array(
    "Préparer le café",
    "Lire les mails",
    "Nourrir le chat"
);

// ======================================================================
//  Fin de la partie PHP d'initialisation
// ======================================================================
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <!-- ============================================================= -->
    <!--  En-tête du document HTML                                     -->
    <!-- ============================================================= -->
    <meta charset="UTF-8">
    <title>Tableau de bord</title>

    <script type="text/javascript">
    // ==========================================================
    //  Fonction appelée lors du clic sur le bouton
    // ==========================================================
    function afficherMessage()
    {
        // Récupération de l'élément message
        var paragrapheMessage = document.getElementById("message");

        // Mise à jour du contenu textuel
        paragrapheMessage.innerHTML = "Bon travail, continue comme ça !";

        // Modification de la couleur du texte
        paragrapheMessage.style.color = "green";
    }
    </script>
</head>
<body>
    <!-- ============================================================= -->
    <!--  Contenu principal de la page                                 -->
    <!-- ============================================================= -->

    <h1>Tableau de bord</h1>

    <p>
        <?php
        // Affichage du message de bienvenue avec la date du jour
        echo "Bonjour " . $nomUtilisateur . " ! Nous sommes le " . $dateCourante;
        ?>
    </p>

    <ul>
        <?php
        // Parcours de la liste des tâches et génération des éléments de liste
        foreach ($taches as $tache) {
            echo "<li>" . $tache . "</li>";
        }
        ?>
    </ul>

    <button type="button" onclick="afficherMessage();">
        Afficher un message
    </button>

    <p id="message"></p>

    <!-- ============================================================= -->
    <!--  Fin du contenu de la page                                    -->
    <!-- ============================================================= -->
</body>
</html>

