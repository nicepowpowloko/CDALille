<img src="../../Logo.png" width="550" height="75" alt="logo">

# Garantir un code propre, lisible et vérifié

## 0. Pourquoi la qualité de code compte

Un programme peut “fonctionner” tout en étant très difficile à lire, à corriger ou à faire évoluer. Un code écrit rapidement, sans règles, devient très vite un poids : chaque modification fait peur, les bugs reviennent sans cesse, et personne n’ose toucher certaines parties du projet. On parle alors de dette technique.

L’objectif de ce module est de montrer qu’un code propre et lisible n’est pas un luxe, mais une condition pour travailler sereinement, surtout en équipe. Un code bien structuré permet de corriger les bugs plus vite, d’ajouter de nouvelles fonctionnalités sans tout casser, et de faciliter l’arrivée de nouveaux développeurs sur le projet.

Des auteurs comme Robert C. Martin avec *Clean Code* ont popularisé un ensemble de bonnes pratiques qui vont dans ce sens. L’idée centrale est simple : le code est lu bien plus souvent qu’il n’est écrit. Il doit donc être pensé pour le lecteur humain avant tout. Les outils automatiques (linters, validateurs, formatteurs, analyseurs statiques) viennent ensuite renforcer ces bonnes pratiques et détecter les problèmes dès que possible.

---

## 1. Lisibilité du code : principes de base (inspirés de Clean Code)

La première couche de qualité ne dépend d’aucun outil : elle tient à la manière d’écrire le code au quotidien.

Un point fondamental est le choix des noms. Les variables, fonctions, classes et fichiers doivent porter des noms qui expriment clairement leur rôle. Un nom comme `totalFacture` est plus utile que `t`, `res` ou `x`. L’idée est qu’un développeur qui lit le code n’ait pas besoin de garder un dictionnaire mental de toutes les abréviations pour comprendre ce qui se passe.

Les fonctions devraient être courtes et faire une seule chose. Lorsqu’une fonction commence à prendre de l’ampleur, il devient difficile de savoir ce qu’elle fait exactement et où se cachent les bugs. Extraire des sous-fonctions avec des noms explicites permet de rendre la logique plus lisible et de faciliter les tests.

Il est important de limiter les niveaux d’imbrication. Des blocs `if` dans des blocs `if`, eux-mêmes dans des `for` et des `while`, finissent par produire ce qu’on appelle parfois du “code en escalier”. Réduire la profondeur, inverser certaines conditions, ou extraire des fonctions intermédiaires permet de clarifier la structure.

La duplication est aussi un ennemi classique. Copier-coller des blocs de code conduit à des situations où une correction est faite à un endroit mais oubliée à un autre. Le principe est de rechercher au maximum les extraits répétés et de les regrouper dans des fonctions réutilisables.

Le code mort (anciennes portions de code laissées en commentaire) est une mauvaise pratique encore fréquente. Il alourdit la lecture, crée de la confusion et complique la maintenance. Avec un outil de versionnement comme `Git`, conserver de l’historique directement dans le fichier n’a plus aucun intérêt : les anciennes versions sont déjà tracées, accessibles et comparables. Il est donc préférable de supprimer toute portion de code devenue inutile.

Enfin, les commentaires ne doivent pas servir à excuser un code illisible. Un commentaire ponctuel peut être utile pour expliquer une décision métier ou un comportement non intuitif, mais dans l’idéal, le code devrait être suffisant pour comprendre la logique générale.

---

## 2. Conventions et organisation des fichiers

Au-delà des règles locales (nommage, longueur des fonctions), la façon dont on organise les fichiers a un impact direct sur la lisibilité. Il est plus simple de travailler sur un projet où l’arborescence est cohérente et prévisible : un dossier pour les templates, un pour les contrôleurs, un pour les entités, un pour les tests, etc.

Les langages et écosystèmes modernes fournissent souvent des conventions. En PHP, les standards PSR (comme PSR-1 ou PSR-12) définissent des règles sur la structure des fichiers, le placement des accolades, l’usage des namespaces. En JavaScript, beaucoup de projets suivent un style inspiré d’Airbnb ou de conventions communes. L’intérêt de ces conventions n’est pas d’être parfaites, mais partagées : tout le monde lit et écrit le même “dialecte”.

Respecter ces conventions facilite l’arrivée sur des projets existants, mais permet aussi d’adopter des outils qui les appliquent automatiquement.

---

## 3. Linters, formatteurs et analyseurs : l’aide automatique

Les outils automatiques jouent un rôle clé pour maintenir la qualité du code dans le temps. On distingue plusieurs familles.

Le linter est un outil qui passe sur le code pour détecter des problèmes de style, des constructions douteuses, des variables non utilisées, des imports manquants ou des risques d’erreurs. En JavaScript, on peut citer ESLint. En CSS, il existe stylelint. En PHP, des outils comme PHP_CodeSniffer ou PHP-CS-Fixer permettent de vérifier et corriger le style.

Le formatteur automatique se charge de mettre en forme le code selon une convention de style définie. Il aligne les indentations, gère les espaces, les retours à la ligne. Des outils comme Prettier pour JavaScript, HTML ou CSS permettent de ne plus perdre de temps à discuter de la position des accolades ou des virgules. Le code est automatiquement réécrit avec un style uniforme.

Enfin, l’analyseur statique va plus loin en inspectant le type des données et les flux d’exécution possibles pour détecter des erreurs avant même l’exécution. En PHP, PHPStan ou Psalm vérifient par exemple que l’on n’accède pas à des propriétés inexistantes, que l’on respecte les types annotés, ou que l’on ne retourne pas `null` là où ce n’est pas prévu.

Dans un projet réel, ces outils sont souvent combinés. Un linter vérifie la cohérence du style et des constructions, un formatteur unifie l’apparence, et un analyseur statique renforce la sécurité du code.

---

## 4. Validation du HTML et du CSS

Un code HTML ou CSS valide n’est pas seulement une question d’esthétique. Des erreurs de balisage peuvent provoquer des comportements étranges dans les navigateurs, nuire à l’accessibilité ou compliquer le travail des outils d’assistance (lecteurs d’écran, par exemple).

Pour le HTML, il existe des validateurs en ligne qui permettent de vérifier la conformité du document par rapport aux standards du W3C. On peut y envoyer une URL, coller le code source ou téléverser un fichier. Ces validateurs signalent les balises mal fermées, les attributs inconnus ou les erreurs de structure.

Pour le CSS, des outils similaires repèrent les propriétés mal écrites, les valeurs invalides ou les sélecteurs incohérents. Les navigateurs modernes intègrent également des outils de développement (les “DevTools”) qui affichent les règles appliquées à un élément, signalent les propriétés non reconnues et permettent de tester rapidement des modifications.

Dans un contexte de formation au développement web, l’usage régulier de ces validateurs habitue les stagiaires à contrôler la qualité de leur code HTML/CSS, au même titre que le reste de la stack.

---

## 5. Intégrer ces outils dans le flux de travail

Les outils de qualité de code prennent toute leur valeur lorsqu’ils sont intégrés au quotidien. Il ne s’agit pas de lancer un linter une fois par mois, mais de l’utiliser en permanence.

Sur un poste développeur, il est possible de configurer l’éditeur (VS Code ou autre) pour lancer automatiquement le linter ou le formatteur à chaque sauvegarde. Le code est alors nettoyé en continu, sans effort particulier. Certains plugins affichent directement les erreurs et avertissements dans le fichier, ce qui permet de les corriger immédiatement.

Dans un projet versionné avec Git, on peut aller plus loin en ajoutant des hooks pre-commit qui bloquent la validation si certains fichiers ne passent pas les tests de style. Les développeurs sont ainsi encouragés à corriger les problèmes avant de pousser leur code.

Enfin, dans une démarche plus avancée, l’intégration continue (CI) permet d’exécuter les linters, les analyseurs statiques et les tests automatisés à chaque push ou à chaque pull request. Si un problème est détecté, la pipeline échoue et signale directement les erreurs.

L’objectif n’est pas de transformer tout cela en contrainte punitive, mais d’installer une culture où la qualité est vérifiée tôt et automatiquement, de manière régulière, afin d’éviter les mauvaises surprises en fin de projet.
