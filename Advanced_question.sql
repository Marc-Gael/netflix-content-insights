/*Calculez le taux de croissance mensuel moyen du contenu ajouté à Netflix pour chaque genre.
Quels sont les 5 genres qui connaissent la croissance la plus rapide ?
*/

    --1.Calculer le nombre de titres ajoutés chaque mois par genre
    SELECT 
        YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
        MONTH(STR_TO_DATE(date_added, '%M %d, %Y')) AS month_added,
        "type", 
        COUNT(*) AS count_titles
    FROM 
        netflix_titles_cleaned
    WHERE 
        date_added IS NOT NULL
    GROUP BY 
        month_added, year_added, type
    ORDER BY
        month_added, year_added, type;


    --2.Calculer le taux de croissance MoM pour chaque genre
    SELECT 
        a.year_added,
        a.month_added,
        a.type,
        a.count_titles,
        ((a.count_titles - IFNULL(b.count_titles, 0)) / IFNULL(b.count_titles, 1)) * 100 AS month_over_month_growth
        
    FROM 

        (SELECT
            YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
            MONTH(STR_TO_DATE(date_added, '%M %d, %Y')) AS month_added,
            type, 
            COUNT(*) AS count_titles
        FROM 
            netflix_titles_cleaned
        WHERE 
            date_added IS NOT NULL
        GROUP BY 
            month_added, year_added, type
        ORDER BY
            month_added, year_added, type) AS a

    LEFT JOIN 

        (SELECT 
            YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
            MONTH(STR_TO_DATE(date_added, '%M %d, %Y')) AS month_added,
            type,
            COUNT(*) AS count_titles
        FROM 
            netflix_titles_cleaned
        WHERE 
            date_added IS NOT NULL
        GROUP BY 
            year_added, month_added, type) AS b
        
    ON 

        a.type = b.type AND a.year_added = b.year_added AND a.month_added = b.month_added + 1
    ORDER BY 
        a.year_added, a.month_added, a.type;
    

    --3.Calcul de la moyenne du taux de croissance MoM pour chaque genre
    SELECT 
        type,
        year_added,
        month_added,
        count_titles AS current_month_titles,
        LAG(count_titles) OVER (PARTITION BY type ORDER BY year_added, month_added) AS previous_month_titles,
        ROUND(
            (count_titles - LAG(count_titles) OVER (PARTITION BY type ORDER BY year_added, month_added)) 
            / LAG(count_titles) OVER (PARTITION BY type ORDER BY year_added, month_added) * 100, 2
        ) AS growth_percentage
    FROM (
        SELECT 
            type,
            YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
            MONTH(STR_TO_DATE(date_added, '%M %d, %Y')) AS month_added,
            COUNT(*) AS count_titles
        FROM netflix_titles_cleaned
        GROUP BY type, year_added, month_added
        ) subquery
    ORDER BY type, year_added, month_added;


    --4.Quels sont les 5 genres qui connaissent la croissance la plus rapide ?
    SELECT 
        type,
        year_added,
        month_added,
        count_titles AS current_month_titles,
        LAG(count_titles) OVER (PARTITION BY type ORDER BY year_added, month_added) AS previous_month_titles,
        ROUND(
            (count_titles - LAG(count_titles) OVER (PARTITION BY type ORDER BY year_added, month_added)) 
            / LAG(count_titles) OVER (PARTITION BY type ORDER BY year_added, month_added) * 100, 2
        ) AS growth_percentage
    FROM (
        SELECT 
            type,
            YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
            MONTH(STR_TO_DATE(date_added, '%M %d, %Y')) AS month_added,
            COUNT(*) AS count_titles
        FROM netflix_titles_cleaned
        GROUP BY type, year_added, month_added
        ) subquery
    ORDER BY type, year_added, month_added
    LIMIT 5;
