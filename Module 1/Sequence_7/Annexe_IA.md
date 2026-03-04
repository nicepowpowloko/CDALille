<img src="../../Logo.png" width="550" height="75" alt="logo">

# **ANNEXE TECHNIQUE – Comprendre un LLM avant de l’installer en local**

Avant de manipuler un modèle de langage localement, il est important d’avoir une idée claire de ce que l’on manipule réellement. Un LLM peut donner l’impression d’être intelligent, cohérent et parfois même “raisonneur”, mais cette apparence repose en réalité sur des mécanismes statistiques très éloignés du fonctionnement d’un être humain. Cette annexe vise à clarifier les concepts fondamentaux, en expliquant comment un LLM représente le texte, comment il calcule la réponse, ce que signifient ses paramètres internes, et comment certains réglages influencent sa manière de répondre.

---

## **1. Les paramètres : la taille réelle du modèle**

Lorsqu’on lit “Mistral 7B”, “Llama 3 8B” ou “Qwen 14B”, le nombre (7B, 8B, 14B) correspond au nombre de paramètres du modèle.
Ces paramètres sont les valeurs numériques que le modèle a appris lors de son entraînement, un peu comme s’il avait mémorisé des centaines de milliards de relations entre les mots, les expressions, les idées, le code, les structures syntaxiques, etc.

Plus il y a de paramètres, plus le modèle est capable de capturer des nuances, de raisonner sur un contexte long ou de donner des réponses élaborées. Cela ne signifie pas qu’il “comprend”, mais simplement qu’il possède une structure statistique plus riche. En contrepartie, plus de paramètres impliquent davantage de mémoire et d’énergie pour exécuter le modèle.

---

## **2. La quantification : réduire le poids du modèle sans le réentraîner**

Un LLM tel qu’il a été entraîné par ses créateurs est généralement représenté en 32 bits ou 16 bits par paramètre. Cela signifie que chaque paramètre occupe une quantité assez importante en mémoire.
Pour l’exécuter en local sur une machine standard, on applique souvent une “quantification”, c’est-à-dire une transformation qui réduit la précision avec laquelle chaque paramètre est stocké. Un modèle quantifié en 8 bits prend deux fois moins de place qu’un modèle en 16 bits. Un modèle quantifié en 4 bits peut être exécuté sur une machine qui, autrement, n’aurait jamais eu assez de mémoire.

Cette opération n’enlève aucun paramètre ; elle les “compacte”. Le modèle reste le même sur le plan structurel, mais il devient plus léger et plus facile à charger. Il peut perdre un peu de finesse, mais pour un usage local, cette perte est très limitée et souvent imperceptible.

---

## **3. La fenêtre de contexte : la mémoire de travail du modèle**

Un LLM ne se souvient pas de tout ce que vous lui avez dit depuis le début de la conversation.
Il travaille avec une “fenêtre de contexte”, qui représente la quantité maximale de texte qu’il peut analyser d’un coup pour produire une réponse. Cette fenêtre se mesure en “tokens”, qui sont des morceaux de mots.
Ainsi, un modèle avec une fenêtre de 8 000 tokens peut analyser l’équivalent de quelques pages de texte. Un modèle comme Llama 3 avec 128 000 tokens peut prendre en compte un chapitre entier, voire un dossier complet.

Plus la fenêtre est grande, plus le modèle peut intégrer d’informations complexes et détaillées dans sa réponse. Cela devient essentiel dans des usages tels que le résumé longue distance, la recherche documentaire interne ou l’analyse de plusieurs fichiers en même temps.

---

## **4. Les tokens : l’unité de base du texte pour un LLM**

Un token n’est pas un mot mais une portion de mot. Les LLM manipulent le texte sous forme de tokens car cela simplifie la représentation mathématique du langage.
Une phrase simple peut contenir entre 5 et 10 tokens ; un paragraphe peut en contenir plusieurs dizaines ; un article complet, plusieurs milliers.
Les limites de contexte, la vitesse d’inférence et même la facturation des API externes sont toutes basées sur cette notion.

---

## **5. La température : contrôler la créativité du modèle**

La température est un réglage très courant lorsqu’on génère du texte. Elle définit à quel point le modèle ose s’éloigner de la réponse la plus probable.
Une température basse (0 à 0,2) force le modèle à être strict, précis et presque déterministe. Cela convient très bien au code, à la logique et aux explications techniques.
Une température moyenne (0,5 à 0,7) donne un compromis entre cohérence et flexibilité.
Une température élevée (1 et plus) rend les réponses plus originales, variées, narratives, mais augmente aussi le risque de dérive ou d’erreur.

---

## **6. Top-K et Top-P : deux façons de limiter le choix des mots**

La température n’est pas le seul réglage qui influence la créativité d’un modèle.
Les paramètres top-k et top-p contrôlent la diversité du vocabulaire utilisé.

Top-k restreint le choix du prochain mot aux k mots les plus probables.
Top-p limite le choix aux mots qui représentent une certaine probabilité cumulée, par exemple les 90 % de mots les plus plausibles.

Ces réglages permettent d’ajuster la précision ou la diversité selon le besoin : un chatbot documentaire interne préférera un réglage strict ; un générateur d’histoires ou d’idées pourra être plus permissif.

---

## **7. Les embeddings : représenter le sens en chiffres**

Un LLM ne comprend pas le texte comme un humain, mais il sait le convertir en “vecteurs”, c’est-à-dire en longues listes de nombres qui représentent la signification statistique d’un mot ou d’une phrase.
Ces vecteurs permettent de comparer des idées, d’identifier des phrases similaires, de repérer des thèmes proches ou de rechercher du contenu dans une base documentaire.

Cette technique est indispensable pour construire un système RAG, où le modèle doit retrouver dans vos documents internes les passages pertinents avant de générer une réponse.

---

## **8. RAG (Retrieval-Augmented Generation) : donner une mémoire externe au modèle**

Un modèle local comme Mistral ou Llama n’a aucune connaissance de vos documents internes.
Le RAG contourne cette limite en procédant en deux étapes :

D’abord, le système analyse vos fichiers (PDF, notes, procédures, documentation technique) pour créer un index vectoriel grâce aux embeddings. Ensuite, lorsqu’une question est posée, il récupère dans cet index les passages pertinents et les inclut dans le prompt, permettant au modèle de répondre à partir de vos données internes.

Sans RAG, un modèle est un outil généraliste.
Avec RAG, il devient un assistant métier personnalisé, capable d’aider réellement dans un contexte professionnel.

---

## **9. Différence entre entraînement et inférence**

Un point essentiel pour le TP : installer un modèle local ne signifie pas le réentraîner.

L’entraînement est une opération extrêmement coûteuse, réservée aux grands acteurs disposant de GPU puissants et de dizaines de milliers d’heures de calcul.
L’inférence, en revanche, consiste simplement à utiliser un modèle déjà entraîné pour générer une réponse. Ollama effectue uniquement de l’inférence.
C’est pour cette raison qu’un modèle performant peut tourner sur un ordinateur portable, tant qu’il est quantifié correctement.

---

## **10. Synthèse générale**

Comprendre ces notions techniques est indispensable avant de manipuler un modèle en local.
Un LLM n’est ni magique ni intelligent ; il repose sur un ensemble de mécanismes mathématiques et statistiques qui ont chacun un impact précis sur son comportement.
Savoir ce que signifient les paramètres, la quantification, le contexte, les tokens ou la température permet de mieux maîtriser l’outil et d’éviter les erreurs d’interprétation ou d’usage.

Une fois ces bases acquises, l’installation via Ollama devient beaucoup plus claire et logique : le modèle téléchargé est une version quantifiée d’un modèle plus vaste, exécuté en inférence, avec des réglages qui déterminent son style de réponse, et que l’on peut combiner à un système documentaire comme le RAG pour lui donner une mémoire adaptée aux besoins réels de l’entreprise.
