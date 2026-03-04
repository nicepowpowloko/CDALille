<img src="../../Logo.png" width="550" height="75" alt="logo">

# Changer les Breakpoints

Pour redéfinir les valeurs des breakpoints de Bootstrap dans votre CSS, vous devrez d'abord comprendre que ces modifications doivent être faites avant de compiler les fichiers source SASS/SCSS de Bootstrap, car les breakpoints sont définis avec des variables SASS. Si vous essayez de les modifier directement dans un fichier CSS après que Bootstrap ait déjà été compilé, cela n'aura aucun effet sur les breakpoints existants utilisés par le framework.

Voici comment procéder avec les fichiers SASS pour ajuster les breakpoints :

1. **Installer Bootstrap via npm** (si ce n'est pas déjà fait) pour obtenir les fichiers SASS :

   ```bash
   npm install bootstrap
   ```

2. **Créez un fichier SASS personnalisé** (par exemple, `custom.scss`) dans lequel vous allez surcharger les variables de breakpoints avant d'importer les fichiers SASS de Bootstrap. Les noms des variables pour les breakpoints dans Bootstrap 5 sont `$grid-breakpoints` et `$container-max-widths`.

   Voici un exemple de contenu pour `custom.scss` :

   ```scss
   // Importation des fonctions nécessaires avant de redéfinir les variables
   @import "node_modules/bootstrap/scss/functions";
   @import "node_modules/bootstrap/scss/variables";

   // Redéfinition des breakpoints
   $grid-breakpoints: (
     xs: 0,
     sm: 576px,
     // Exemple de nouvelle valeur pour 'sm'
     md: 768px,
     // Exemple de nouvelle valeur pour 'md'
     lg: 992px,
     // Exemple de nouvelle valeur pour 'lg'
     xl: 1200px,
     // Exemple de nouvelle valeur pour 'xl'
     xxl: 1400px // Exemple de nouvelle valeur pour 'xxl',
   );

   // Redéfinition des largeurs max du conteneur si nécessaire
   $container-max-widths: (
     sm: 540px,
     md: 720px,
     lg: 960px,
     xl: 1140px,
     xxl: 1320px,
   );

   // Importation du reste de Bootstrap
   @import "node_modules/bootstrap/scss/bootstrap";
   ```

3. **Compilez votre fichier SASS personnalisé** pour générer le CSS final. Vous pouvez utiliser des outils comme Node-sass, Dart Sass, ou un plugin de build comme Webpack, Gulp, etc. Voici un exemple de commande avec Dart Sass :

   ```bash
   sass custom.scss custom.css
   ```

4. **Incluez le fichier CSS généré** (`custom.css`) dans votre projet HTML au lieu du fichier CSS standard de Bootstrap.

En ajustant les valeurs dans `$grid-breakpoints` et éventuellement `$container-max-widths`, vous personnalisez les points de rupture et les largeurs max des conteneurs de votre projet Bootstrap pour qu'ils correspondent à vos besoins spécifiques en matière de design responsive.
