<img src="../../Logo.png" width="550" height="75" alt="logo">

# **PARTIE 1 | Présentation du shell Bash**

 **Bash** *Bourne Again SHell* est à la fois :

- **un interpréteur de commandes** (shell),

- **et un langage de script** permettant d’automatiser des tâches.

Il est utilisé par défaut dans la majorité des systèmes **GNU/Linux** et dans de nombreuses variantes d’Unix. Bash permet de lancer des commandes système, d’enchaîner des opérations (via les *pipes* `|`), de manipuler les fichiers, les processus et les flux d’entrée/sortie.

Bash est conçu pour **orchestrer** des outils du système.  
Il **n’est pas destiné** à écrire des programmes complexes, mais excelle dans l’automatisation et l’administration système.

---

## 1) **Origine et histoire**

- **1977** : *Bourne Shell* (`sh`) — Stephen Bourne (AT&T / Bell Labs)  
  → Shell historique d’Unix.

- **1989** : *Bash* — Brian Fox (Projet GNU / Free Software Foundation)  
  Objectif : créer une alternative **libre**, compatible avec `sh` mais enrichie (alias, historique, fonctions, complétion…).

Grâce au mouvement du logiciel libre, Bash devient le shell par défaut dans la plupart des distributions Linux et se trouve aujourd’hui au cœur de l’administration système.

---

## 2) **Avantages de Bash**

Bash est souvent considéré comme simple à apprendre car sa syntaxe est directe et relativement proche de formulations naturelles. La plupart des commandes expriment clairement ce qu’elles font, ce qui permet à un débutant de progresser rapidement sans être submergé par de la théorie. Son principal intérêt réside dans sa capacité à automatiser efficacement des tâches répétitives : copier des fichiers, organiser des dossiers, lancer des sauvegardes, analyser des journaux, démarrer ou arrêter des services, etc.

Bash est présent sur pratiquement tous les systèmes GNU/Linux et sur de nombreuses variantes Unix, et peut également être utilisé sous Windows grâce à WSL ou Cygwin. Sa disponibilité quasi universelle signifie qu’apprendre Bash, c’est apprendre un outil immédiatement réutilisable dans un grand nombre d’environnements. Enfin, le shell bénéficie d’une documentation très riche et d’une communauté importante : il est facile de trouver des exemples, des solutions et des réponses aux problèmes rencontrés.

---

## 3) **Limites de Bash**

Bash n’est pas conçu comme un langage généraliste. Il est limité lorsque l’on doit manipuler des structures complexes, effectuer des calculs importants, traiter des données volumineuses ou développer des programmes comportant une logique métier élaborée. Dans ces situations, des langages comme Python, JavaScript, Go ou Rust sont plus adaptés.

De plus, la gestion des erreurs en Bash est parfois moins explicite, ce qui peut amener à écrire des scripts qui fonctionnent « la plupart du temps » mais qui échouent silencieusement dans certains cas. Enfin, Bash n’est pas performant pour les calculs intensifs, car il repose sur l’orchestration de commandes externes plutôt que sur un moteur interne optimisé.

En résumé, Bash est un excellent langage pour piloter le système, mais ce n’est pas un langage pour développer des applications.

---

## 4) **Quand utiliser Bash ?**

Bash prend tout son sens dès qu’il s’agit d’automatiser une tâche répétitive, d’administrer un système Linux ou d’exécuter des opérations de maintenance. Il est parfaitement adapté à la gestion de sauvegardes, au traitement de journaux (logs), au déploiement d’applications, à l’installation automatisée de logiciels ou à l’exécution programmée de tâches régulières. Il se situe au cœur de nombreux environnements d’intégration et déploiement continus (CI/CD) et s’utilise fréquemment dans des scripts de service, de démarrage ou d’initialisation système.

---

## 5) **Que vaut Bash comme langage de programmation ?**

En tant que langage, Bash est avant tout un langage d’**orchestration**. Il ne brille pas par sa capacité à encapsuler des modèles objets, à structurer des architectures logicielles complexes ou à écrire des algorithmes évolués. Là où d'autres langages manipulent des objets ou des structures, Bash manipule des fichiers, des processus et des flux d’entrée-sortie. Son rôle n’est pas de remplacer Python ou Java, mais de les appeler, les combiner, les automatiser ou les déployer.

Bash est donc un langage « fin de chaîne » : on l’utilise pour mettre en mouvement des composants existants.

---

## 6) **Quelle importance selon les métiers ?**

Pour un **développeur**, connaître Bash permet d’être autonome en environnement Linux, de comprendre la structure d’un projet sur un serveur, d’utiliser efficacement Git, Python, Node ou Docker sans dépendre d’une interface graphique. Cela développe aussi la compréhension du fonctionnement interne d’un système.

Pour un **administrateur système ou réseau**, Bash est l’un des outils centraux. C’est avec Bash que l’on automatise la création de comptes, les sauvegardes, les déploiements de logiciels, l’analyse des journaux, la surveillance, la sécurité. Sans Bash, l’administration devient manuelle, lente, répétitive et donc fragile.

Pour un **ingénieur DevOps**, Bash est indispensable. Les pipelines CI/CD, l’infrastructure automatisée, les conteneurs Docker, les orchestrations Kubernetes, l’automatisation des déploiements et l’observabilité utilisent tous Bash comme langage de glue. Même si un DevOps utilise d’autres outils (Ansible, Terraform, Python, Go), Bash reste la base sur laquelle tout repose.

---

## 7) **Panorama des principaux shells (histoire & systèmes)**

| Shell                   | Date                                              | Auteur                     | Notes essentielles                                       | Systèmes compatibles                                                                                          |
| ----------------------- |:-------------------------------------------------:| -------------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Thompson Shell**      | 1971                                              | Ken Thompson (Bell Labs)   | Premier shell Unix (très minimal)                        | Uniquement **Unix historiques** (1ère génération), plus utilisé aujourd’hui                                   |
| **Bourne Shell (`sh`)** | 1977                                              | Stephen Bourne (Bell Labs) | Base syntaxique héritée par tous les shells modernes     | **Unix System V**, BSD, **tous Linux** via variantes (`dash`), **systèmes embarqués**                         |
| **C Shell (`csh`)**     | 1978                                              | Bill Joy (BSD)             | Syntaxe inspirée du langage C, historique intégré        | **BSD**, UNIX, disponible sur **Linux**, mais peu recommandé aujourd’hui                                      |
| **KornShell (`ksh`)**   | 1983                                              | David Korn (Bell Labs)     | Shell avancé : fonctions, tableaux, calcul arithmétique  | **Unix System V**, **AIX**, **Solaris**, **BSD**, **Linux** (package `ksh`)                                   |
| **Bash**                | **1989**                                          | Brian Fox (GNU/FSF)        | Shell libre standard sur Linux, très répandu             | **Linux** (par défaut), **BSD**, **macOS jusqu’à 10.14**, **WSL**, **Cygwin**, **MinGW**, *porté sur Windows* |
| **Z Shell (`zsh`)**     | 1990                                              | Paul Falstad               | Personnalisable, très utilisé interactif (Oh-My-Zsh)     | **Linux**, **macOS (par défaut depuis 10.15)**, **BSD**, **WSL**, **Cygwin**                                  |
| **Fish**                | 2005                                              | Axel Liljencrantz          | Convivial, auto-complétion intelligente, syntaxe lisible | **Linux**, **macOS**, **BSD**, **WSL**, **Cygwin**, Windows via MSYS2                                         |
| **PowerShell**          | 2006 (Windows); 2016 (Open Source cross-platform) | Microsoft                  | Shell orienté objets (retourne des objets, pas du texte) | **Windows**, **Linux**, **macOS**, **WSL**, **Docker** (images officielles)                                   |

**Zsh est aujourd’hui le shell interactif par défaut sur macOS.**
Depuis macOS Catalina (2019), Apple a choisi Zsh comme shell par défaut à la place de Bash. Ce changement a deux raisons : Zsh est plus flexible et offre une expérience interactive plus confortable (suggestions, autocomplétion avancée, personnalisation), et la licence GPLv3 de Bash posait des contraintes juridiques pour Apple. Cela a fait de Zsh un outil largement utilisé dans les environnements professionnels où les développeurs travaillent sur macOS (développement web, DevOps, data science). Bien qu’il soit différent, Zsh reste très compatible avec Bash, ce qui facilite la transition et justifie que les deux soient enseignés ensemble.

**PowerShell est indispensable en environnement Windows et Active Directory.**
PowerShell n’est pas qu’un shell : c’est un système complet d’automatisation basé sur la manipulation d’objets plutôt que de simples chaînes de texte. Dans les entreprises qui utilisent Windows Server, Active Directory, Microsoft 365, Exchange, ou Azure, PowerShell est l’outil d’administration central. Il permet de gérer des utilisateurs, des machines, des politiques de sécurité ou des déploiements de manière cohérente et reproductible. Depuis son passage en open source, PowerShell s’utilise également sur Linux et macOS, ce qui en fait un outil transversal dans les infrastructures hybrides.

**KornShell est encore courant dans les banques, l’assurance et les mainframes.**
KornShell a été largement adopté dans les années 1980 et 1990 sur les systèmes UNIX propriétaires comme AIX et Solaris. De nombreux scripts de production critiques ont été écrits en ksh dans les secteurs bancaire, assurantiel, télécoms et énergie. Ces systèmes sont encore en fonctionnement, parfois depuis des décennies, et leur stabilité est considérée comme prioritaire. Cela signifie que les administrateurs et ingénieurs qui travaillent dans ces environnements doivent souvent être capables de lire, maintenir ou adapter du code écrit en ksh. KornShell reste donc présent non par modernité, mais par continuité opérationnelle.

**C Shell est aujourd’hui considéré comme un shell à connaître mais rarement à utiliser.**
C Shell a eu une importance historique, notamment dans l’univers BSD, car il apportait des fonctionnalités avancées pour l’époque, comme l’historique des commandes. Cependant, sa syntaxe est source fréquente d’erreurs, notamment en scripting, et il présente des limitations importantes en comparaison des shells modernes. Aujourd’hui, il reste présent pour des raisons de compatibilité sur certains systèmes, mais il n’est presque jamais recommandé pour l’écriture de nouveaux scripts. Le connaître sert surtout à comprendre l’évolution des outils Unix et reconnaître les scripts hérités que l’on peut encore croiser.

---

## 8) **Bash est le standard sur toutes les distributions Linux.**

Dans la quasi-totalité des distributions GNU/Linux (Debian, Ubuntu, Mint, CentOS, Red Hat, Arch, etc.), Bash est installé par défaut et constitue l’outil principal d’interaction en ligne de commande. Cela signifie que lorsque l’on ouvre un terminal, on se retrouve dans Bash sans action particulière. C’est le langage d’automatisation le plus répandu dans les infrastructures Linux, qu’elles soient petites (serveur personnel) ou très larges (cloud, hébergement, systèmes embarqués). Ainsi, la connaissance de Bash est incontournable dès que l’on travaille avec Linux, que ce soit pour administrer un système, automatiser une tâche ou intervenir en entreprise ou en production.

Bash est un langage essentiel dès que l’on travaille dans un environnement Linux. Il ne remplace pas les langages de développement classiques, mais il occupe une position centrale pour automatiser, orchestrer, administrer et déployer. Il constitue un **socle de compétences technique** partagé par les développeurs, les administrateurs systèmes, les ingénieurs réseaux et les DevOps.
