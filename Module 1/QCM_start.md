### **QCM – Module 1**

**1) Quel est l’un des avantages principaux d’un environnement Linux pour le développement web ?**  
A. Il permet d’installer facilement des outils en ligne de commande utilisés dans l’industrie.
B. Il empêche les erreurs de compilation.  
C. Il remplace automatiquement les environnements de production.  
D. Il ne nécessite aucune mise à jour système.

**2) Quel est le rôle principal d’un IDE (ex : VS Code) ?**  
A. Fournir une interface centralisée regroupant édition de code, extensions et outils de débogage.  
B. Convertir automatiquement une maquette en code HTML/CSS.  
C. Garantir l'optimisation du code à la compilation.  
D. Générer la documentation du projet sans intervention humaine.

**3) Quelle commande Bash permet de naviguer dans l’arborescence des dossiers ?**  
A. checkdir  
B. cd  
C. goto  
D. movepath

**4) À quoi sert une connexion SSH (OpenSSH) ?**  
A. À copier du code sur un serveur local sans réseau.  
B. À se connecter à distance à une machine en sécurisant la communication.  
C. À lancer automatiquement les tests unitaires.  
D. À chiffrer des bases de données pendant leur exécution.

**5) Quelle est la fonction principale de Git dans un projet ?**  
A. Gérer l’historique et les versions du code dans le temps.  
B. Compiler le code source plus rapidement.  
C. Vérifier la cohérence du code avant son exécution.  
D. Synchroniser automatiquement le projet avec un serveur FTP.

**6) Lorsqu’on fusionne deux branches avec Git, quel terme décrit cette opération ?**  
A. Checkout  
B. Merge  
C. Fetch  
D. Revert

**7) Quelle est l’utilisation principale de GitHub Pages ?**  
A. Déployer un site web statique directement à partir d’un dépôt.  
B. Héberger des bases de données en production.  
C. Automatiser les déploiements CI/CD de projets Docker.  
D. Effectuer les revues de code sur des dépôts privés uniquement.

**8) Docker permet principalement de :**  
A. Créer des environnements de développement reproductibles, isolés du système hôte. 
B. Écrire automatiquement du code selon le langage choisi.  
C. Accélérer l’exécution des applications en doublant les ressources.  
D. Remplacer le système d’exploitation hôte.

**9) Parmi les pratiques suivantes, laquelle contribue réellement à garantir un code lisible et maintenable ?**  
A. Utiliser une convention de nommage et appliquer un formatage cohérent.  
B. Minimiser le nombre de fichiers en regroupant le maximum de code dans un seul fichier.  
C. Éviter les commentaires pour alléger le code.  
D. Utiliser des noms de variables très courts pour taper plus vite.

**10) Dans une démarche d’usage responsable des IA d’assistance au développement, laquelle de ces pratiques est appropriée ?**  
A. Vérifier et comprendre les suggestions avant de les intégrer au code.  
B. Accepter automatiquement les solutions générées pour gagner du temps.  
C. Laisser l’IA décider de l’architecture du projet sans intervention.  
D. Utiliser l’IA pour contourner les exercices d’apprentissage.

**11) Lors de l’installation d’un environnement Linux, quel répertoire contient généralement les fichiers personnels de l’utilisateur ?**  
A. /root  
B. /usr  
C. /home  
D. /var

**12) Dans VS Code, à quoi sert l’installation d’extensions ?**  
A. À augmenter la puissance du processeur.  
B. À ajouter des fonctionnalités adaptées au langage ou au workflow.  
C. À rendre la fenêtre principale plus esthétique.  
D. À créer automatiquement un environnement virtuel.

**13) Quelle commande Bash permet d’exécuter un script présent dans le dossier courant ?**  
A. run script.sh  
B. ./script.sh  
C. exec script.sh  
D. open script.sh

**14) Lors de l’utilisation de SSH, quel élément garantit l’authenticité de la machine distante ?**  
A. La clé publique du serveur.  
B. Le mot de passe administrateur du poste local.  
C. Le nom du répertoire utilisateur.  
D. Le port choisi pour la connexion.

**15) Quelle est la bonne description d’un commit dans Git ?**  
A. Une sauvegarde d’un instantané du code et de son historique.  
B. Une fusion automatique entre deux branches.  
C. Une copie du projet envoyée sur le cloud.  
D. L’exécution des tests unitaires avant déploiement.

**16) Quelle commande permet de récupérer les modifications distantes d’un dépôt GitHub ?**  
A. git send  
B. git download  
C. git pull  
D. git update

**17) Dans GitHub, quel outil facilite le suivi des demandes, tâches ou améliorations ?**  
A. Issues  
B. Forks  
C. Actions  
D. Releases

**18) Lorsqu’on crée un conteneur Docker, lequel de ces éléments décrit la configuration du conteneur (image, ports, services…) ?**  
A. Le fichier README.md  
B. Le fichier docker-compose.yml  
C. Le terminal Bash  
D. Le fichier .gitignore

**19) Quelle est une bonne pratique pour garantir la lisibilité d’un code collaboratif ?**  
A. Exiger l’usage d’un style unique et partagé (linting / formatage automatique).  
B. Laisser chaque contributeur définir son propre style librement.  
C. Ne pas utiliser de commentaires pour alléger l’affichage.  
D. Placer tous les scripts dans le même fichier pour simplifier la recherche.

**20) Quel est un risque réel lié à l’usage non réfléchi d’une IA d’assistance au développement ?**  
A. L’IA refuse d’exécuter le code.  
B. Le code généré peut contenir des erreurs ou des failles de sécurité.  
C. Les fichiers du projet sont automatiquement supprimés.  
D. L’IA empêche toute collaboration via GitHub.

---

### **Corrigé argumenté – QCM Module 1**

| N°     | Réponse correcte | Justification pédagogique                                                                                                                                                                                                      |
| ------ | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **1**  | **A**            | Linux est largement utilisé en environnement professionnel car il facilite l’accès aux outils de développement en ligne de commande (Git, SSH, Docker, Node, Python, etc.), souvent natifs ou mieux intégrés que sous Windows. |
| **2**  | **A**            | Un IDE propose un environnement complet : éditeur, coloration syntaxique, extensions, terminal intégré, débogueur, et outils facilitant la productivité du développeur.                                                        |
| **3**  | **B**            | `cd` (change directory) permet de se déplacer dans l’arborescence. Les autres propositions sont des erreurs typiques d’apprenants qui confondent avec d'autres environnements.                                                 |
| **4**  | **B**            | SSH sert à se connecter à distance à une machine de façon chiffrée, afin de travailler ou administrer un serveur en sécurité.                                                                                                  |
| **5**  | **A**            | Git est un système de gestion de versions : il enregistre les modifications du code, permet de revenir en arrière et de travailler à plusieurs sur la même base.                                                               |
| **6**  | **B**            | Le terme « merge » désigne la fusion de deux branches. C’est une opération centrale dans le travail collaboratif.                                                                                                              |
| **7**  | **A**            | GitHub Pages permet de publier facilement un site statique à partir d’un dépôt GitHub, souvent utilisé pour des portfolios ou des documentations.                                                                              |
| **8**  | **A**            | Docker isole des environnements logiciels dans des conteneurs reproductibles, assurant que le code fonctionne de la même manière sur toutes les machines (dev, test, prod).                                                    |
| **9**  | **A**            | La lisibilité du code repose sur : noms explicites, indentation régulière, conventions partagées, et documentation minimale. Cela améliore la maintenance collective.                                                          |
| **10** | **A**            | L’IA doit être utilisée comme outil d’assistance. L’apprenant reste responsable du code produit : comprendre, évaluer, adapter et vérifier les suggestions sont essentiels.                                                    |
| 11     | **C**            | `/home` contient les répertoires personnels des utilisateurs ; `/root` est le compte super administrateur.                                                                                                                     |
| 12     | **B**            | Les extensions ajoutent des outils : support de langages, linters, thèmes, debuggers…                                                                                                                                          |
| 13     | **B**            | `./script.sh` exécute un script du dossier courant, après permission `chmod +x`.                                                                                                                                               |
| 14     | **A**            | La clé publique du serveur permet de vérifier l’identité de la machine et sécurise la connexion.                                                                                                                               |
| 15     | **A**            | Un commit est un instantané versionné du code à un moment donné.                                                                                                                                                               |
| 16     | **C**            | `git pull` récupère (fetch) *et* fusionne les modifications d’un dépôt distant.                                                                                                                                                |
| 17     | **A**            | Les *Issues* permettent de suivre tâches, bugs, demandes d’évolution.                                                                                                                                                          |
| 18     | **B**            | `docker-compose.yml` décrit les services, images, volumes, ports d’un environnement conteneurisé.                                                                                                                              |
| 19     | **A**            | Un style partagé (formatteur + conventions) garantit la cohérence du projet collaboratif.                                                                                                                                      |
| 20     | **B**            | Les suggestions IA doivent toujours être analysées : elles peuvent contenir erreurs ou failles.                                                                                                                                |
