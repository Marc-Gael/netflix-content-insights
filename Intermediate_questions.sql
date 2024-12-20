/*3/ Retrouvez le top 3 des réalisateurs ayant le plus de contenu sur Netflix. 
Affichez le nom du réalisateur, le nombre de ses titres et l'année de son contenu le plus récent.
*/
SELECT director, COUNT(title) AS count_title, MAX(release_year) AS annee_plus_recente
FROM netflix_titles_cleaned
GROUP BY director
ORDER BY count_title DESC, annee_plus_recente DESC
LIMIT 3;


/*4/ Pour chaque année de 2015 à 2021, calculez le pourcentage de films et de séries télévisées ajoutés à Netflix.
*/
SELECT 
	  YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added, 
	  ROUND(SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS movie_percentage, 
      ROUND(SUM(CASE WHEN type = 'Tv Show' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS tv_percentage 
FROM netflix_titles_cleaned 
WHERE YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) BETWEEN 2015 AND 2021
GROUP BY YEAR(STR_TO_DATE(date_added, '%M %d, %Y'))
ORDER BY year_added DESC;