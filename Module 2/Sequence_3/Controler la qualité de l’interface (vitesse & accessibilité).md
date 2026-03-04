<img src="../../Logo.png" width="550" height="75" alt="logo">

# Cours : Contrôler la qualité de l’interface (vitesse & accessibilité)

Créer un site web, ce n’est pas seulement écrire du HTML et du CSS : il faut vérifier qu’il est **rapide**, **accessible** et **conforme aux bonnes pratiques**.
Pour cela, on utilise deux types d’outils : **Chrome Lighthouse** et les **outils d’accessibilité/performance de Firefox**.

---

## 1 Lighthouse (Chrome) – Analyse automatique

**Comment l’ouvrir ?**

* Clic droit → **Inspecter**
* Onglet **Lighthouse**
* Choisir : *Performance* + *Accessibility*
* Lancer l’analyse → un rapport est généré

### Ce que Lighthouse évalue

#### Performance (vitesse)

* poids des images
* temps de chargement
* CSS/JS trop lourds
* ressources bloquantes

#### Accessibilité

* contrastes insuffisants
* images sans `alt`
* labels manquants
* titres mal organisés
* liens pas explicites

**Objectif :** comprendre les points rouges, corriger, relancer l’audit.

---

## 2 Firefox – Accessibilité & Performance (équivalents Lighthouse)

Firefox ne possède pas Lighthouse, mais propose **deux outils très complets** :

---

### Inspecteur d’accessibilité (Accessibility Inspector)

Outils développeur → **Accessibilité**

Permet de vérifier :

* hiérarchie correcte des titres (`h1`, `h2`, `h3`)
* landmarks sémantiques (`<main>`, `<nav>`, `<header>`, `<footer>`)
* **contraste automatique** (vert = bon / rouge = mauvais)
* images sans `alt`
* labels associés aux champs du formulaire
* navigation clavier & focus

C’est un excellent outil pédagogique : il montre ce que “voit” un lecteur d’écran.

---

### Outil de performance (Performance)

Outils développeur → **Performance**

Permet d’analyser :

* temps de chargement
* poids total de la page
* scripts trop lourds
* recalculs CSS importants
* images trop volumineuses

Idéal pour détecter des ralentissements dans la page du chalet.

---

## 3 Console & Network (Chrome/Firefox)

Ces deux onglets sont communs aux navigateurs.

### Console

Permet de vérifier :

* erreurs JavaScript
* ressources non trouvées (404)
* problèmes de script bloquant

Une console propre = site sain.

### Network

Donne :

* le **poids total** de la page (objectif : < 1 Mo)
* le temps de chargement de chaque élément
* les images trop lourdes
* le nombre de requêtes

Très utile pour optimiser les images du TP Chalet.

---

## 4 Workflow simple

1. Ouvrir la page du mini-site Chalet.
2. Lancer **Lighthouse** (Chrome) → repérer les points à corriger.
3. Vérifier l’**accessibilité** dans Firefox (titles, alt, labels, contraste).
4. Vérifier les **performances** dans Firefox (poids, images, scripts).
5. Corriger :

   * alt manquants
   * titres mal organisés
   * images trop lourdes
   * liens pas explicites
6. Relancer Lighthouse pour voir les progrès.

---

## 5 Application au TP Chalet

Il faut principalement corriger :

* les alt des photos du chalet,
* les titres (`h1`, `h2`, `h3`) bien hiérarchisés,
* le formulaire correctement labellisé,
* les images redimensionnées (pas en 4000px),
* un contraste suffisant pour le texte sur fond coloré,
* supprimer erreurs dans la Console.
