""" Nous avons constaté des irrégularités dans le fichier. Nous avons avons donc décidé de l'analyser
de plus près avec Python"""

"""1. Importer le fichier afin de conaître ces caractéristiques"""
import pandas as pd

file_path = 'sample_data/netflix_titles.csv'
data = pd.read_csv(file_path)

data.head(), data.info()



"""2. Importer le fichier avec le bon encodage"""
import pandas as pd

file_path = 'sample_data/netflix_titles.csv'
data = pd.read_csv(file_path, encoding='ISO-8859-1')

data.head(), data.info()


"""3. Nettoyer le fichier et l'enregistrer au format CSV (UTF-8) """
cleaned_data = data.loc[:, ~data.columns.str.contains('^Unnamed')]


"""4. """
cleaned_file_path = 'sample_data/netflix_titles_cleaned.csv'
cleaned_data.to_csv(cleaned_file_path, index=False)

cleaned_file_path