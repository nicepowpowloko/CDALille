<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Déroulé pédagogique – M1S7**

## L’Outil IA : Comprendre, maîtriser, sécuriser

---

## **1 Comprendre ce qu’est réellement un LLM – 45 min**

**Objectifs :**

- Déconstruire l’idée que “l’IA comprend” : voir le fonctionnement mécanique des modèles.

- Distinguer entraînement, inférence, embeddings, tokens, quantification.

- Identifier les limites structurelles : hallucinations, biais, absence d’intention.

**Supports utilisés :**  
*Outils_IA.md – sections 1, 2 et 3 (fonctionnement, illusions d’intelligence, risques)*  

*Annexe_IA.md – sections 1 à 7 (paramètres, quantification, contexte, tokens, température)*  

**Activités :**

- Présentation guidée :
  
  - LLM = modèle statistique prédictif
  
  - Transformer = architecture dominante depuis 2017
  
  - hallucinations = “plausible ≠ vrai”

- Démonstration en direct :  
  – exemple d’hallucination contrôlée sur une question simple  
  – analyse : d’où vient l’erreur ?

- Mini-quiz oral : “Qu’est-ce qu’un token ? Qu’est-ce qu’un paramètre ? Pourquoi un LLM n’a pas de mémoire ?”

**Livrable court :**

- 1 phrase résumant : “Un LLM n’est pas un cerveau parce que…”

---

## **2 Usages professionnels, souveraineté & dépendances – 1 h 15**

Basé sur : *Outils_IA.md – enjeux souveraineté, sécurité, géopolitique*  

**Objectifs :**

- Comprendre les risques liés à l’usage d’un service IA externe.

- Identifier les notions de souveraineté numérique et de confidentialité.

- Évaluer les impacts géopolitiques d’un modèle non maîtrisé.

**Contenu abordé :**

- Qu’implique “envoyer une donnée à un LLM externe” ?

- Logs, métadonnées, copies temporaires : pourquoi la confidentialité n’est jamais totale.

- Dépendance stratégique : acteurs américains / chinois vs initiatives européennes.

- Impact écologique : entraînement, API cloud vs modèle local quantifié.

**Activités :**

- Étude de 3 cas d’usage professionnels :
  
  - RH : données sensibles
  
  - développement : code privé
  
  - juridique : documents confidentiels  
    → identifier pourquoi *aucun* ne doit transiter vers un service externe.

- Discussion : “Votre entreprise accepte-t-elle qu’un stagiaire charge un document interne dans ChatGPT ? Pourquoi ?”

**Livrables :**

- Une liste “Données que je peux envoyer / données que je ne dois jamais envoyer”.

---

## **3 Risques : hallucinations, biais & HITL – 1 h 30**

Basé sur :  
*Outils_IA.md – sections Hallucinations & Biais*  

*Annexe IA – paramètres influençant les comportements (température, top-k/p)*  

**Objectifs :**

- Identifier et comprendre les hallucinations : formes, causes, risques.

- Comprendre les biais : culturels, socio-économiques, politiques, linguistiques.

- Introduire le concept **HITL (Human In The Loop)** : décision finale humaine.

**Activités :**

- Démonstration :
  
  - poser une question technique simple (ex : commande Linux imaginaire)
  
  - laisser le modèle halluciner
  
  - analyser pourquoi

- Atelier en groupe :
  
  - repérer les biais dans 3 réponses données par un LLM
  
  - expliquer comment les détecter
  
  - proposer une reformulation pour les corriger

**Livrables :**

- Mini-fiche : “Comment je repère une hallucination ? Comment je la valide ?”

---

## **4 Maîtriser un LLM en local : installation avec Ollama – 1 h 30**

Basé sur : *Outils_IA.md – section installation et commandes Ollama*  

**Objectifs :**

- Installer Ollama sur sa machine (Linux/Windows/macOS).

- Télécharger un modèle open-source (Gemma, Mistral, Llama…).

- Comprendre la différence entre paramétrage, quantification et fenêtre de contexte.

- Utiliser le modèle en ligne de commande.

**Contenu abordé :**

- Installation (curl, installeur Windows/macOS).

- Commandes essentielles :
  
  - `ollama pull nom-du-modèle`
  
  - `ollama run modèle`
  
  - `ollama list`, `ollama ps`

- Téléchargement d’un modèle léger : `gemma3:4b`

- Première requête locale : *sans connexion Internet, sans cloud*

- Démonstration API locale :
  
  ```bash
  curl http://localhost:11434/api/generate \
    -d '{ "model": "gemma3", "prompt": "Explique le RAG." }'
  ```

**Activités :**

- Installation guidée sur chaque poste.

- Test du modèle et vérification de la confidentialité (aucun trafic réseau).

- Analyse : influence de la température et du top-p sur les réponses.

**Livrables :**

- Modèle local fonctionnel + 1 réponse produite en local.

---

## **5 Vers un usage avancé : RAG local & intégration métier – 1 h 30**

Basé sur :  
*Annexe_IA.md – sections embeddings, RAG, différence entraînement / inférence*  

**Objectifs :**

- Comprendre comment donner une “mémoire documentaire” à un modèle local.

- Découvrir les bibliothèques permettant de créer un assistant interne souverain.

- Prototyper un usage métier réaliste.

**Contenu abordé :**

- RAG = **Retrieval-Augmented Generation**  
  – embeddings → index → récupération → réponse enrichie

- LlamaIndex, LangChain, ChromaDB, Milvus.

- Exemple d’intégration :
  
  - assistant RH interne avec règles RGPD
  
  - chatbot documentaire sur un projet Symfony
  
  - aide-mémoire technique dans un intranet

**Activités :**

- Mini-démo : envoyer un PDF interne dans un index local.

- Simulation : “Comment intégrer Ollama dans un site Symfony / un script PHP ?”

**Livrables :**

- Schéma de workflow RAG + note d’intention “mon premier assistant interne”.

---

# **Résumé clair du déroulé**

1. **Comprendre un LLM** (45 min)  
   Modèle statistique, tokens, paramètres, illusions d’intelligence.

2. **Souveraineté & sécurité** (1 h 15)  
   Confidentialité, dépendance cloud, enjeux géopolitiques.

3. **Risques : hallucinations & biais** (1 h 30)  
   Détection, correction, HITL, reproduction des biais humains.

4. **Ollama : installation locale** (1 h 30)  
   Installation, modèle local, API interne sécurisée.

5. **RAG & intégration métier** (1 h 30)  
   Embeddings, index vectoriel, assistants documentaires internes.
