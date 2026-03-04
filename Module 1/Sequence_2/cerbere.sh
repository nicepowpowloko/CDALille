#!/bin/bash

# Démarrer le chronomètre en millisecondes
start_time=$(date +%s%3N)

# Nom du fichier d'entrée (le texte à analyser)
INPUT_FILE="Iliade.txt"

# Vérifier si le fichier existe
if [ ! -f "$INPUT_FILE" ]; then
  echo "Fichier '$INPUT_FILE' non trouvé."
  exit 1
fi

# Nom du fichier de sortie HTML
OUTPUT_FILE="Bash_Cerb.html"

# Initialiser un tableau associatif pour stocker les occurrences
declare -A counts

# Lire chaque caractère du fichier et compter les occurrences
while IFS= read -r -n1 char; do
  # Si le caractère existe déjà dans le tableau, incrémenter, sinon initialiser à 1
  if [[ -n "$char" ]]; then
    counts["$char"]=$((counts["$char"] + 1))
  fi
done < "$INPUT_FILE"

# Calculer le temps d'exécution en millisecondes
end_time=$(date +%s%3N)
execution_time=$((end_time - start_time))

# Démarrer la génération du fichier HTML
echo "<!DOCTYPE html>" > $OUTPUT_FILE
echo "<html>" >> $OUTPUT_FILE
echo "<head><title>Bash_Cerb</title></head>" >> $OUTPUT_FILE
echo "<body>" >> $OUTPUT_FILE
echo "<h1>Occurrences des caractères dans le fichier texte</h1>" >> $OUTPUT_FILE
echo "<p><strong>Temps d'exécution : </strong>$execution_time ms</p>" >> $OUTPUT_FILE
echo "<table border='1'>" >> $OUTPUT_FILE
echo "<tr><th>Caractère</th><th>Occurrences</th></tr>" >> $OUTPUT_FILE

# Écrire les résultats dans le fichier HTML
for key in "${!counts[@]}"; do
  case "$key" in
    " ") display_char="Espace" ;;
    $'\n') display_char="Nouvelle ligne" ;;
    $'\t') display_char="Tabulation" ;;
    *) display_char="$key" ;;
  esac
  echo "<tr><td>$display_char</td><td>${counts[$key]}</td></tr>" >> $OUTPUT_FILE
done

# Fermer le HTML
echo "</table>" >> $OUTPUT_FILE
echo "</body>" >> $OUTPUT_FILE
echo "</html>" >> $OUTPUT_FILE

echo "Analyse terminée. Résultats écrits dans '$OUTPUT_FILE'."
echo "Temps d'exécution : $execution_time ms"

