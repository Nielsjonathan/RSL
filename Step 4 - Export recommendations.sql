/*A new table is created to store the recommendations*/
CREATE TABLE recommendationsSummary AS 
SELECT url, rank FROM movies WHERE rank > 0.01 ORDER BY rank DESC LIMIT 50;
/*The recommendations get exported to a csv file*/
\copy (SELECT * FROM recommendationsSummary) to '/home/pi/RSL/test.csv' WITH csv;
