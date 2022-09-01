{% docs __overview__ %}

Bienvenue sur votre Data Catalog. Ici, vous pouvez :
- Explorer les tables disponibles dans votre DataWarehouse
- Comprendre les interactions entre vos données
- Voir de quelles données viennent vos analyses et de quelles analyses vienent vos données.

## Navigation dans l'onglet **Données**
Cet onglet vous permet de voir les tables et vues de votre DataWarehouse.  
Le DataWarehouse est découpé en 2 bases de données :
### Base de données **brocoli-internal-back**
Les données brutes préparées par les Ingénieurs de la Donnée. Cette base de données est organisée en 3 zones :
- **stg** : les données brutes, importées depuis vos logiciels transactionnels
- **prp** : les données sont préparées pour être analysées
- **ods** : les données sont prêtes à être analysées

### Base de données **brocoli-internal-front**
Les données sont exposéees en vues orientées-métier. Cette base de données est organisée en **domaines fonctionnels** :
- **macro** : Données macro-environnementales

## Navigation dans l'onglet **Analyses**
Cet onglet regroupe toutes les analyses, métriques et autres consommations de données.

### Consommation des données
Cette rubrique montre les différentes façons dont vos données sont consommées :
- **Dashboards** : Tableaux de bords et Rapports

## Exploration du graphique de lignée des données
Vous pouvez cliquer sur l'icône bleue dans le coin inférieur droit de la page pour afficher **le graphique de lignée des données**.

### Mode plein écran
Sur les pages, vous verrez les parents et enfants immédiats de la table que vous explorez. En cliquant sur l'icône de *plein écran* (en haut à droite de ce volet de lignage), vous pourrez voir toutes les tables qui sont utilisées pour construire ou sont construites à partir de la table que vous explorez.

Une fois en plein écran, vous pourrez utiliser la syntaxe de sélection de table **--select** et **--exclude** pour filtrer les modèles dans le graphique. 

Notez que vous pouvez également cliquer avec le bouton droit sur les modèles pour filtrer et explorer le graphique de manière interactive.

{% enddocs %}