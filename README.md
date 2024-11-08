# SQL-Data-Analysis
## Datenquelle 
Die Daten stammen aus zwei Datensätzen von kaggle, die Informationen über Apps im Apple App Store enthalten. Der applestore-Datensatz enthält Details wie App-Namen, Ratings und Genres, während der apple_desc-Datensatz die Beschreibungstexte der Apps umfasst. https://www.kaggle.com/datasets/ramamet4/app-store-apple-data-set-10k-apps?select=appleStore_description.csv
## Projektübersicht 

In diesem Projekt wird eine Analyse der Daten über Apps aus dem Apple App Store durchgeführt, um Einblicke in die beliebteste App-Kategorien, Bewertungstrends und App-Merkmale zu gewinnen. Ziel ist es, herauszufinden, welche Merkmale die App-Ratings und Beliebtheit beeinflussen, um damit wertvolle Erkenntnisse über die App-Landschaft und Nutzerpräferenzen zu erhalten.

## Aufgabenstellung 

Die Analyse konzentriert sich auf die Beantwortung folgender Fragen:

1. **Welche Genres haben die höchste Anzahl an Apps? Welche Genres sind weniger vertreten?**
2. **Wie hoch ist das durchschnittliche Rating und wie differenziert sich diese nach Genres?**
3. **Gibt es Unterschiede in den Ratings zwischen kostenpflichtigen und kostenlosen Apps?**
4. **Wie beeinflusst die Anzahl der verfügbaren Sprachen das Rating? Erhalten Apps mit mehr unterstützten Sprachen höhere Bewertungen?**
5. **Besteht ein Zusammenhang zwischen der Detailliertheit der App-Beschreibung und dem Rating?**
6. **Welche App hat in jedem Genre das beste Rating?**

## Zusammenfassung der Ergebnisse

### 1. **Genres mit den meisten und wenigsten Apps**
   -Die meisten Apps im Datensatz gehören zum Genre „Games“, gefolgt von „Entertainment“ und „Education“. Die wenigsten Apps gibt es in den Kategorien "Catalogs" und "Medical".

![image](https://github.com/user-attachments/assets/d4ef6357-0491-422d-b0ff-3dc151dd2934)

### 2. **Durchschnittliche  Ratings nach Genres**
   -Das durchschnittliche Rating liegt bei 3,53 (0 = schlechtestes und 5 = bestes Rating). Die durchschnittliche besten Ratings sind im Genre "Productivity", die schlechtesten in "Catalogs". 

![image](https://github.com/user-attachments/assets/324806f4-1f9c-422a-b008-0910933212e4)

### 3. **Unterschiede zwischen den Ratings bei kostenpflichtigen und kostenlosen Apps**
   -Kostenpflichtige Apps haben im Durchschnitt ein höheres Rating (3,72) im Vergleich zu kostenlosen Apps (3,38). 

![image](https://github.com/user-attachments/assets/dca67661-09a6-4229-b326-82f670aa06b5)

### Explorative Datenanalyse

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

### Herausarbeiten der wichtigsten Insights

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
