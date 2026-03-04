<img src="../../Logo.png" width="550" height="75" alt="logo">

# Déroulé pédagogique – M2 S2

**Objectif global :** passer du responsive manuel → à Bootstrap → à la personnalisation → puis au TP « Chalet Montagne ».

## 1 Media Queries (cours + démo)

**Durée :** ~1h30
**Support :** fichier *Media_Queries.html* + *style2.css*
**Référence :**  

**Contenu :**

* Rappel du responsive natif avec CSS
* Breakpoints classiques (mobile-first)
* max-width / min-width / orientation
* Tester en direct dans le navigateur
* Interprétation visuelle des changements (couleurs, tailles, blocs)

**Exercice rapide :**

* Modifier l’en-tête, le paragraphe et le footer selon 3 tailles d’écran.

Transition : « Ce que nous venons de faire à la main, Bootstrap le fait automatiquement. »

---

## 2 Démo Bootstrap (démonstration guidée)

**Durée :** 20 à 30 min
**Support :** *bootstrap-grille.html* + *style.css*
**Référence :**  

**Contenu :**

* CDNs → Bootstrap installé en 5 secondes
* Le container, la row, les col-*
* Le label de breakpoint en JS pour montrer le comportement
* Classes responsive : col-sm / col-md / col-lg…
* Démonstration du changement de couleur selon largeur

**Objectif :** comprendre visuellement la logique de Bootstrap.

---

## 3 Bootstrap (cours + mini-atelier)

**Durée :** 1h30
**Support :** fichier *Bootstrap.md*
**Référence :**

**Contenu :**

* Grille Bootstrap : container / row / col
* Classes utilitaires (m- / p- / text-center / bg- etc.)
* Cards, navbar, boutons
* Construire une page simple :

  * Une navbar
  * 3 cards en grille responsive
  * Une section texte en container

**Mini-atelier :**
Construire une structure basique Bootstrap pour « Chalet Montagne » (page d’accueil).

---

## 4 Change_breakpoint (personnalisation)

**Durée :** 30 min
**Support :** *Change_Breakpoint.md*
**Référence :**

**Contenu :**

* Comprendre que les breakpoints sont dans le SCSS, pas le CSS
* Les variables : $grid-breakpoints et $container-max-widths
* Exemple d’un custom.scss
* Cas où l’on surcharge simplement avec des media queries CSS

**Objectif :** montrer que Bootstrap n’est pas “figé”.

---

## 5 TP Bootstrap – Projet “Chalet Montagne”

**Durée :** 2h à 2h30
**Support :** *TP_bootstrap.md*
**Référence :**

**Consignes principales :**

* Intégrer Bootstrap sur toutes les pages
* Transformer le header en navbar Bootstrap
* Utiliser la grille pour structurer chaque page
* Fiche chalet → card Bootstrap complète
* Page d’accueil → sections + grille de cards
* Formulaire réservation → form Bootstrap
* Nettoyage des anciens styles

**Livrable :**
Un mini-site 100% responsive utilisant Bootstrap.

---

## Résumé

1. **Media queries** : le responsive à la main.
2. **Démo Bootstrap** : comment Bootstrap gère ça automatiquement.
3. **Bootstrap** : grille, utilitaires, composants.
4. **Changer les breakpoints** : personnaliser Bootstrap.
5. **TP** : transformer le site “Chalet Montagne” en full Bootstrap.
