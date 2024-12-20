# Netflix Data Analysis

## Description

Ce projet explore le jeu de données des films et séries disponibles sur Netflix, en analysant divers aspects du contenu de la plateforme. L'analyse couvre des questions allant du niveau débutant au niveau avancé, offrant ainsi un aperçu approfondi des tendances et des caractéristiques du contenu Netflix, notamment les réalisateurs les plus populaires, la répartition des types de contenu, et la croissance des genres.

## Jeu de données

Le jeu de données contient des informations détaillées sur les films et séries présents sur Netflix, avec les colonnes suivantes :

- **`show_id`** : ID unique pour chaque titre  
- **`type`** : Type du contenu (Film ou Série)  
- **`title`** : Titre du contenu  
- **`director`** : Nom(s) du ou des réalisateur(s)  
- **`cast`** : Noms des acteurs et actrices  
- **`country`** : Pays d'origine du contenu  
- **`date_added`** : Date d'ajout sur Netflix  
- **`release_year`** : Année de sortie du contenu  
- **`rating`** : Note attribuée au contenu (ex. PG, R, TV-MA)  
- **`duration`** : Durée du contenu  
- **`listed_in`** : Catégories ou genres auxquels le contenu appartient  
- **`description`** : Description du contenu  

## Objectifs du projet

L'objectif de ce projet est d'analyser et de tirer des insights à partir du jeu de données Netflix. Voici les questions clés auxquelles ce projet répond :

### Questions de niveau Débutant

1. Combien de films et de séries sont présents dans le jeu de données ? Afficher le compte pour chaque type de contenu.
2. Quel pourcentage de contenu n'a pas de pays associé ?

### Questions de niveau Intermédiaire

3. Quels sont les 3 réalisateurs ayant le plus de contenu sur Netflix ? Afficher le nom, le nombre de titres, et l'année de leur contenu le plus récent.
4. Pour chaque année de 2015 à 2021, quel pourcentage de films et de séries ont été ajoutés sur Netflix ?

### Question de niveau Avancé

5. Quelle est la croissance moyenne mois après mois du contenu ajouté sur Netflix pour chaque genre ? Quels sont les 5 genres les plus en forte croissance ?

# Outils et technologies utilisés

## Analyse des Données Netflix

Ce projet utilise Python et Pandas pour charger et explorer un dataset contenant les titres disponibles sur Netflix, et SQL pour analyser les données.

## Étapes

1. Chargement des données avec pandas.
2. Inspection rapide des données dans un environnment Python (Jupyter Notebook):
   - **Aperçu** des 5 premières lignes.
   - **Résumé** des informations, y compris les types de colonnes et les valeurs manquantes.

### Exemple de Code 1

```python
import pandas as pd

file_path = 'sample_data/netflix_titles.csv'
data = pd.read_csv(file_path)

data.head(), data.info()
```

Résultat : Le fichier contient des caractères qui ne peuvent pas être lus avec l'encodage par défaut (utf-8). Je vais essayer un autre encodage (comme latin1 ou ISO-8859-1) pour charger les données correctement.

### Exemple de Code 2

```python
import pandas as pd

file_path = 'sample_data/netflix_titles.csv'
data = pd.read_csv(file_path, encoding='ISO-8859-1')

data.head(), data.info()
```

Résultat : Plusieurs colonnes inutiles (12 à 25) contiennent uniquement des valeurs nulles.

#### Étapes suivantes :
1. Nettoyer les colonnes inutiles
2. Générer un fichier nettoyé prêt à l'analyse
3. Charger ces données dans une base de données SQL pour des analyses avancées
4. Proposer des requêtes SQL pertinentes pour répondre aux problématiques métiers


Je vais commencer par nettoyer les données pour simplifier les analyses.
Il est donc nécessaire de supprimer les colonnes inutiles:
```python
cleaned_data = data.loc[:, ~data.columns.str.contains('^Unnamed')]
```

Sauvegarder les données nettoyées dans un fichier CSV pour SQL
```python
cleaned_file_path = '/mnt/data/netflix_cleaned.csv'
netflix_data_cleaned.to_csv(cleaned_file_path, index=False) # index=False empêchera python de créer de nouveaux index dans le fichier

cleaned_file_path
```


