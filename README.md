# Netflix Data Analysis

## Description

Ce projet explore le jeu de données des films et séries disponibles sur Netflix, en analysant divers aspects du contenu de la plateforme. L'analyse couvre des questions allant du niveau débutant au niveau avancé, offrant ainsi un aperçu approfondi des tendances et des caractéristiques du contenu Netflix, notamment les réalisateurs les plus populaires, la répartition des types de contenu, et la croissance des genres.

## Jeu de données

Le jeu de données est disponible [ici](https://www.kaggle.com/datasets/rahulvyasm/netflix-movies-and-tv-shows?resource=download) contient des informations détaillées sur les films et séries présents sur Netflix, avec les colonnes suivantes :

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

### [Questions de niveau Débutant](https://github.com/Marc-Gael/netflix-content-insights/blob/main/T%C3%A2ches_sql/Beginner%20questions.sql)

1. Combien de films et de séries sont présents dans le jeu de données ? Afficher le compte pour chaque type de contenu.
2. Quel pourcentage de contenu n'a pas de pays associé ?

### [Questions de niveau Intermédiaire](https://github.com/Marc-Gael/netflix-content-insights/blob/main/T%C3%A2ches_sql/Intermediate_questions.sql)

3. Quels sont les 3 réalisateurs ayant le plus de contenu sur Netflix ? Afficher le nom, le nombre de titres, et l'année de leur contenu le plus récent.
4. Pour chaque année de 2015 à 2021, quel pourcentage de films et de séries ont été ajoutés sur Netflix ?

### [Question de niveau Avancé](https://github.com/Marc-Gael/netflix-content-insights/blob/main/T%C3%A2ches_sql/Advanced_question.sql)

5. Quelle est la croissance moyenne mois après mois du contenu ajouté sur Netflix pour chaque genre ? Quels sont les 5 genres les plus en forte croissance ?

# Outils et technologies utilisés

- **SQL** : L'élément central de mon analyse, me permettant d'interroger la base de données et de découvrir des informations critiques.
- **Python** : L'outil utilisé pour explorer er nettoyer les données.
- **Jupyter Notebook** : Pour écrire du Python.
- **MySQL** : Le système de gestion de base de données choisi.
- **GitHub** : EPour le partage de mes scripts et analyses, permettant la collaboration et le suivi du projet.

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

# Quelques analyses            


### 1. Retrouvez le top 3 des réalisateurs ayant le plus de contenu sur Netflix


```sql
SELECT director, COUNT(title) AS count_title, MAX(release_year) AS annee_plus_recente
FROM netflix_titles_cleaned
WHERE director IS NOT NULL AND director != ''
GROUP BY director
ORDER BY count_title DESC, annee_plus_recente DESC
LIMIT 3;
```
Voici les résultats des Top directeurs:
- **Rajiv Chilaka:** Avec 19 titres, et 2018 comme année de sortie la plus récente.
- **RaÃºl Campos, Jan Suter:** Avec 18 titres, et 2018 comme année de sortie la plus récente.
- **Marcus Raboy:** Avec 16 titres, et 2020 comme année de sortie la plus récente.

![Top Paying Roles](Assets/top_3_des_réalisateurs_ayant_le_plus_de_contenu_sur_Netflix.png)
*Graphique représentant le top 3 des directeurs; créé avec Excel.*

### 2. Calculez le pourcentage de films et de séries télévisées ajoutés à Netflix de 2015 à 2021


```sql
SELECT 
	  YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added, 
	  ROUND(SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS movie_percentage, 
	  ROUND(SUM(CASE WHEN type = 'Tv Show' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS tv_percentage 
FROM netflix_titles_cleaned 
WHERE YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) BETWEEN 2015 AND 2021
GROUP BY YEAR(STR_TO_DATE(date_added, '%M %d, %Y'))
ORDER BY year_added DESC;
```
Résultats:
- **Dominance des Films (2015-2018)** : Netflix a initialement mis l’accent sur les films.
- **Montée des Séries TV (2018-2021)** : La part des séries TV a augmenté, atteignant 45% en 2020, probablement en réponse à la demande croissante de contenus longs et immersifs.
- **Adaptation aux Abonnés** : Netflix ajuste son catalogue pour captiver les abonnés, en misant sur les séries TV pour encourager le binge-watching.

![Top Paying Roles](Assets/pourcentage_de_films_et_de_séries_télévisées_ajoutés_à_Netflix_(2015-2021).png)
*Graphique représentant le pourcentage des contenus ajoutés sur Netflix de 20215 à 2021; créé avec Excel.*


# Conclusion
**1. Diversification croissante du contenu**
- Insight : La part croissante des séries TV (de 30% en 2015 à 45% en 2020) montre une stratégie de fidélisation à travers des contenus récurrents et immersifs.
- Marketing : Mettre en avant les séries comme leviers d'engagement, avec des campagnes axées sur les nouvelles saisons et binge-watching.
- Produit : Renforcer les recommandations personnalisées basées sur les séries populaires et les habitudes de visionnage longues.


**2. Contributions des réalisateurs**
- Insight : Certains réalisateurs dominent avec des sorties répétées (Rajiv Chilaka, Marcus Raboy).
- Marketing : Mettre en avant ces réalisateurs à travers des collections dédiées.
- Produit : Créer des profils de réalisateurs avec une sélection de leurs œuvres et des suggestions basées sur leur style.


**Synthèse Stratégique**
- Engagement : Valoriser les séries comme piliers de fidélisation.
- Acquisition : Promouvoir le catalogue de films pour séduire une audience large.
- Rétention : Investir dans des contenus régionaux et des séries populaires pour répondre aux besoins diversifiés.
