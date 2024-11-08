--Erstellen der Tabellen

CREATE Table applestore (
	index integer, id integer,track_name text, size_bytes numeric, 
	currency text, price numeric, rating_count_tot numeric, 
	rating_count_ver numeric, user_rating numeric, 
	user_rating_ver numeric,ver text, cont_rating text, prime_genre text,
	sup_devices_num numeric, ipadSc_urls_num numeric, lang_num numeric, 
	vpp_lic numeric
)


CREATE Table apple_desc (
	id integer,track_name text, size_bytes numeric, app_desc text
)


Überprüfen der Datenqualität:
--Vergleichen der Anzahl an Apps je Tabelle (ist ident)

SELECT COUNT(DISTINCT id) AS UniqueIDs
FROM applestore

SELECT COUNT(DISTINCT id) AS UniqueIDs
FROM apple_desc


--Nach Null-Werten suchen (es waren keine vorhanden)

SELECT COUNT(*) AS NullWerte
FROM applestore
WHERE track_name ISNULL OR user_rating ISNULL 

SELECT COUNT(*) AS NullWerte
FROM apple_desc
WHERE app_desc ISNULL 


Explorative Datenanalyse:
--Auswertungen der App-Bewertungen (0-5, Durchschnittliche Bewertung: 3,52)

SELECT 
	MIN(user_rating) AS minrating,
	MAX(user_rating) AS maxrating,
	AVG(user_rating) AS Durschschnitt_Rating
FROM applestore

Analyse und ableiten von Insights:

--Anzahl der Apps nach Genre

SELECT 
	prime_genre AS Genre, 
	COUNT(*) AS Anzahl_Apps
FROM applestore
GROUP BY Genre
ORDER BY Anzahl_Apps DESC

--Auswertungen der App-Reviews nach Genre 

SELECT 
	prime_genre AS Genre,
	ROUND(AVG(user_rating),2) AS Durschschnitt_Rating
FROM applestore
GROUP BY Genre
ORDER BY Durschschnitt_Rating DESC


--Rating Unterschied von gratis und kostenpflichtigen Apps 

SELECT 
	CASE WHEN price >0 THEN 'kostenpflichtig' ELSE 'gratis' END AS App_Typ,
	ROUND(AVG(user_rating),2) AS Durschschnitt_Rating
FROM applestore
GROUP BY App_Typ


--Rating Unterschied aufgrund der Anzahl von angebotenen Sprachen der Apps 

SELECT
	CASE WHEN lang_num < 10 THEN 'weniger als 10 Sprachen'
		WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 Sprachen'
		ELSE 'mehr als 30 Sprachen' END AS Sprachkategorien,
	ROUND(AVG(user_rating),2)) AS Durschschnitt_Rating
FROM applestore
GROUP BY Sprachkategorien
ORDER BY Durschschnitt_Rating DESC


--Zusammenhang zwischen Detailliertheit (Länge) der App Beschreibung und dem Rating

SELECT 
	CASE WHEN length(d.app_desc) < 500 THEN 'kurz'
		WHEN length(d.app_desc) BETWEEN 500 AND 1000 THEN 'mittel'
		ELSE 'lang' END AS Detailliertheit_Beschreibung,
	ROUND(AVG(user_rating),2) AS Durschschnitt_Rating 
FROM applestore AS s
JOIN apple_desc AS d ON s.id = d.id
GROUP BY Detailliertheit_Beschreibung
ORDER BY Durschschnitt_Rating DESC


SELECT
	prime_genre As Genre,
	track_name AS App_Titel,
	user_rating AS rating
FROM (
	SELECT
	prime_genre,
	track_name,
	user_rating,
	RANK() OVER(PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS Rang
	FROM applestore) AS s
WHERE s.Rang = 1
