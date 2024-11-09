# Mobile App Store Datenanalyse
## Datenquelle 
Die Daten stammen aus zwei Datensätzen von kaggle, die Informationen über Apps im Apple App Store enthalten. Der applestore-Datensatz enthält Details wie App-Namen, Ratings und Genres, während der apple_desc-Datensatz die Beschreibungstexte der Apps umfasst. https://www.kaggle.com/datasets/ramamet4/app-store-apple-data-set-10k-apps?select=appleStore_description.csv

Einige spannende Spalten lauten wie folgt:

**applestore:**
- track_name: App-Name
- size_bytes: Größe (in Bytes)
- price: Preisbetrag
- rating_count_tot: Nutzerbewertung (alle Versionen)
- user_rating: Durchschnittliche Nutzerbewertung (alle Versionen)
- prime_genre: Hauptgenre

**apple_desc:**
- app_desc: Anwendungsbeschreibung/App-Beschreibung
    
## Projektübersicht 

Dieses Projekt analysiert die Daten der Apps aus dem Apple App Store, um Einblicke in die beliebteste App-Kategorien, Bewertungstrends und App-Merkmale zu gewinnen. Ziel ist es, herauszufinden, welche Merkmale die App-Ratings und Beliebtheit beeinflussen, um damit wertvolle Erkenntnisse über die App-Landschaft und Erfolgsfaktoren für zukünftig entwickelte Apps zu gewinnen.

## Aufgabenstellung 

Die Analyse konzentriert sich auf die Beantwortung folgender Fragen:

1. **Welche Genres haben die höchste Anzahl an Apps? Welche Genres sind weniger häufig vertreten?**
2. **Wie hoch ist das durchschnittliche Rating und wie differenziert sich dieses nach Genre?**
3. **Gibt es Unterschiede in den Ratings zwischen kostenpflichtigen und kostenlosen Apps?**
4. **Wie wird das Rating durch die Anzahl an verfügbaren Sprachen beeinflusst?**
5. **Besteht ein Zusammenhang zwischen der Detailliertheit der App-Beschreibung und dem Rating?**
6. **Was ist die am besten bewertete App pro Genre?**

## Zusammenfassung der Ergebnisse

### 1. **Genres mit den meisten und wenigsten Apps**
   Die meisten Apps im Datensatz gehören zum Genre „Games“, gefolgt von „Entertainment“ und „Education“. Die wenigsten Apps gibt es in den Kategorien "Catalogs" und "Medical".

![image](https://github.com/user-attachments/assets/70d0182d-e71a-4d17-b71e-54bcf3e80909)


### 2. **Durchschnittliche  Ratings nach Genres**
   Das durchschnittliche Rating liegt bei 3,53 (0 = schlechtestes und 5 = bestes Rating). Die durchschnittlich besten Ratings erhalten Apps im Genre "Productivity", die schlechtesten in "Catalogs". 

![image](https://github.com/user-attachments/assets/324806f4-1f9c-422a-b008-0910933212e4)


### 3. **Unterschiede zwischen den Ratings bei kostenpflichtigen und kostenlosen Apps**
   Kostenpflichtige Apps haben im Durchschnitt ein höheres Rating (3,72) im Vergleich zu kostenlosen Apps (3,38). 

![image](https://github.com/user-attachments/assets/dca67661-09a6-4229-b326-82f670aa06b5)

### 4. **Einfluss der Anzahl der verfügbaren Sprachen auf das App Rating**
   Apps welche in 10 bis 30 Sprachen angeboten werden, haben im Durchschnitt höhere Ratings.

![image](https://github.com/user-attachments/assets/06c273f5-94fc-4698-b8d6-735143fd9f6a)

### 5. **Zusammenhang zwischen Detailliertheit der App-Beschreibung und dem Rating**
   Apps mit detaillierten (bzw. längeren) Beschreibungen haben höhere Ratings als Apps mit kürzeren Beschreibungen.

![image](https://github.com/user-attachments/assets/e856de3b-00e0-430d-b022-79d2a4559a8f)

### 6. **App mit dem besten Rating je Genre**
   Im Anschluss sind die am besten bewerteten Apps je Genre angeführt.

![image](https://github.com/user-attachments/assets/1caebbc7-4010-426e-9525-504ea97e0d2b)


## Fazit

Diese Analyse verdeutlicht Trends und Präferenzen im Apple App Store und zeigt, dass längere Beschreibungen, eine große Sprachauswahl und kostenpflichtige Apps tendenziell höhere Ratings erhalten. Genres „Games“, „Entertainment“ und „Education“ könnten bereits gesättigt sein. Eventuell besteht aufgrund der schwächeren Konkurrenz (weniger Apps) gepaart mit schlechteren Ratings der bestehenden Apps ein höheres Potenzial im Genre "Catalogs". 
