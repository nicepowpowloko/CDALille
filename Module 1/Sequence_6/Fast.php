<?php
// Fast.php 
$dateDuJour = date('d/m/Y');
$nom = "Invité";
$taches = ["Préparer le café","Lire les mails","Nourrir le chat"];
?>
<!doctype html>
<html>
<head>
<title>Dashboard</title>
<script>
function clicBouton(){
var m=document.getElementById("msg");
m.innerHTML="Bon travail, continue comme ça !";
m.style.color="green"
}
</script>
</head>
<body>
<h1>Tableau de bord</h1>
<p>
<?php
echo "Bonjour ".$nom." ! Nous sommes le ".$dateDuJour;
?>
</p>
<ul>
<?php
for($i=0;$i<count($taches);$i++){
echo "<li>".$taches[$i]."</li>";
}
?>
</ul>
<button onclick="clicBouton()">Afficher un  message</button>
<p id="msg"></p>
</body>
</html>

