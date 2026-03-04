```mermaid
erDiagram
  CLASSE {
    int idClasse
    string nomClasse
  }

  SALLE {
    int numSalle
  }

  PROFESSEUR {
    int idProf
    string nomProfesseur
  }

  MATIERE {
    int idMatiere
    string matiereEnseignee
  }

  ELEVE {
    int idEleve
    string nomEleve
    string prenomEleve
  }

  NOTE {
    int idNote
    decimal note
  }

  ENSEIGNEMENT {
    int idEnseignement
    decimal nombreHeures
  }

  %% Règles :
  %% - 1 classe -> 1 salle et réciproquement
  CLASSE ||--|| SALLE : "est_dans"

  %% - Chaque matière est enseignée par 1 seul professeur
  PROFESSEUR ||--o{ MATIERE : "enseigne"

  %% - Heures fixées pour (classe, matière)
  CLASSE ||--o{ ENSEIGNEMENT : "suit"
  MATIERE ||--o{ ENSEIGNEMENT : "concerne"

  %% - 1 note par (élève, matière)
  ELEVE ||--o{ NOTE : "obtient"
  MATIERE ||--o{ NOTE : "pour"
  ```
