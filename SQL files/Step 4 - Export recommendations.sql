/*A new table is created to store the recommendations*/
CREATE TABLE IF NOT EXISTS recommendationsSummary AS 
SELECT url, rank1 FROM movies WHERE rank1 > 0.01 ORDER BY rank1 DESC LIMIT 50;
CREATE TABLE IF NOT EXISTS recommendationsTitle AS 
SELECT url, rank2 FROM movies WHERE rank2 > 0.01 ORDER BY rank2 DESC LIMIT 50;
CREATE TABLE IF NOT EXISTS recommendationsStarring AS 
SELECT url, rank3 FROM movies WHERE rank3 > 0.01 ORDER BY rank3 DESC LIMIT 50;
/*The recommendations get exported to a csv file*/
\copy (SELECT * FROM recommendationsSummary) to '/home/pi/RSL/RecommendationsSummary.csv' WITH csv;
\copy (SELECT * FROM recommendationsTitle) to '/home/pi/RSL/RecommendationsTitle.csv' WITH csv;
\copy (SELECT * FROM recommendationsStarring) to '/home/pi/RSL/RecommendationsStarring.csv' WITH csv;