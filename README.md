# SQL-Data-Analysis
## Datenquelle 
Die Daten stammen aus zwei Datensätzen von Kaggle, die Informationen über Apps im Apple App Store enthalten: applestore und apple_desc. Der applestore-Datensatz enthält Details wie App-Namen, Bewertungen und Genres, während der apple_desc-Datensatz die Beschreibungstexte der Apps umfasst. Der Link zum Datensatz ist: Apple App Store Dataset.

## Projektübersicht 
In diesem Projekt wird eine umfassende Analyse der Daten über Apps aus dem Apple App Store durchgeführt, um Einblicke in die beliebteste App-Kategorien, Bewertungstrends und App-Merkmale zu gewinnen. Ziel ist es, herauszufinden, welche Merkmale die App-Bewertungen und Beliebtheit beeinflussen, um damit wertvolle Erkenntnisse über die App-Landschaft und Nutzerpräferenzen zu erhalten.

## Aufgabenstellung 
Die Analyse richtet sich auf folgende Fragestellungen:

App-Verteilung nach Genre: Welche Genres haben die höchste Anzahl an Apps? Welche Genres sind weniger vertreten?
Bewertungsauswertung: Wie hoch ist die durchschnittliche Bewertung und wie variieren die Bewertungen zwischen Genres?
Vergleich zwischen kostenpflichtigen und kostenlosen Apps: Gibt es Unterschiede in den Bewertungen zwischen kostenpflichtigen und kostenlosen Apps?
Bewertung und Anzahl an Sprachen: Wie beeinflusst die Anzahl der verfügbaren Sprachen das Rating? Erhalten Apps mit mehr unterstützten Sprachen höhere Bewertungen?
Niedrig bewertete Genres: Welche Genres haben im Durchschnitt die schlechtesten Bewertungen?
Zusammenhang zwischen Beschreibungslänge und Rating: Besteht ein Zusammenhang zwischen der Detailliertheit der App-Beschreibung und den Bewertungen?
Top bewertete Apps je Genre: Welche App hat in jedem Genre die beste Bewertung?

### Überprüfen der Daten Qualität

Die meisten Apps im Datensatz gehören zum Genre „Games“ (ca. 50 %), gefolgt von „Entertainment“ und „Education“.


SELECT prime_genre, COUNT(*) AS NumApps
FROM applestore
GROUP BY prime_genre
ORDER BY NumApps DESC
Bewertungsauswertung:

Die App-Bewertungen reichen von 0 bis 5, mit einer durchschnittlichen Bewertung von 3,52.


SELECT MIN(user_rating) AS minrating, MAX(user_rating) AS maxrating, AVG(user_rating) AS Durchschnitt_Rating
FROM applestore
Vergleich zwischen kostenpflichtigen und kostenlosen Apps:

Kostenpflichtige Apps haben im Durchschnitt ein höheres Rating (3,72) im Vergleich zu kostenlosen Apps (3,38).


SELECT CASE WHEN price > 0 THEN 'kostenpflichtig' ELSE 'gratis' END AS App_Typ,
       AVG(user_rating) AS Durchschnitt_Rating
FROM applestore
GROUP BY App_Typ
Bewertung und Anzahl an Sprachen:

Apps, die zwischen 10 und 30 Sprachen unterstützen, haben durchschnittlich das höchste Rating.


SELECT CASE WHEN lang_num < 10 THEN 'weniger als 10 Sprachen'
            WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 Sprachen'
            ELSE 'mehr als 30 Sprachen' END AS Sprachkategorien,
       AVG(user_rating) AS Durchschnitt_Rating
FROM applestore
GROUP BY Sprachkategorien
ORDER BY Durchschnitt_Rating DESC
Niedrig bewertete Genres:

Genres wie „Catalogs“, „Finance“ und „Book“ haben im Durchschnitt die niedrigsten Bewertungen.


SELECT prime_genre, AVG(user_rating) AS Durchschnitt_Rating
FROM applestore
GROUP BY prime_genre
ORDER BY Durchschnitt_Rating
LIMIT 10
Zusammenhang zwischen Beschreibungslänge und Rating:

Die Analyse zeigt, dass längere Beschreibungen (über 1000 Zeichen) tendenziell mit höheren Bewertungen verbunden sind.


SELECT CASE WHEN length(d.app_desc) < 500 THEN 'kurz'
            WHEN length(d.app_desc) BETWEEN 500 AND 1000 THEN 'mittel'
            ELSE 'lang' END AS Detaillierungsgrad_Beschreibung,
       AVG(user_rating) AS Durchschnitt_Rating 
FROM applestore AS s
JOIN apple_desc AS d ON s.id = d.id
GROUP BY Detaillierungsgrad_Beschreibung
ORDER BY Durchschnitt_Rating DESC
Top bewertete Apps je Genre:

Jede Kategorie wurde analysiert, um die App mit der höchsten Bewertung innerhalb des Genres zu identifizieren.


SELECT prime_genre, track_name, user_rating
FROM (SELECT prime_genre, track_name, user_rating,
             RANK() OVER(PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS Rang
      FROM applestore) AS s
WHERE s.Rang = 1



Fazit Diese Analyse verdeutlicht Trends und Präferenzen im Apple App Store und zeigt, dass längere Beschreibungen, eine große Sprachauswahl und kostenpflichtige Apps tendenziell höhere Bewertungen erhalten. Es wäre interessant, in weiteren Studien die Gründe für die schwachen Bewertungen in bestimmten Genres tiefer zu untersuchen und die Beziehung zwischen Beschreibungstexten und Benutzerinteresse näher zu analysieren.
