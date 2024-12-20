
/*1/ Combien y a-t-il de films et d'émissions de télévision dans l'ensemble de données ?
Afficher le nombre pour chaque type
*/
SELECT "type", COUNT(type) AS counts
FROM netflix_titles_cleaned
GROUP BY type;


/*2/ Quel est le pourcentage des contenus ne sont pas associés à un pays ?
*/
SELECT (COUNT(*) * 100 / (SELECT COUNT(*) FROM netflix_titles_cleaned)) AS pourcentage_pays_manquant
FROM netflix_titles_cleaned
WHERE country IS NULL OR country = '';