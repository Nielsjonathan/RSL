ALTER TABLE movies
ADD lexemesStarring tsvector;
UPDATE movies
SET lexemesStarring = to_tsvector(Starring);
SELECT url FROM movies WHERE lexemesStarring @@ to_tsquery('Leonardo DiCaprio');
ALTER TABLE movies
ADD rank float4;
UPDATE movies
SET rank = ts_rank(lexemesStarring,plainto_tsquery((SELECT Starring FROM movies WHERE url='inception')));
CREATE TABLE recommendationsBasedOnStarringField AS SELECT url, rank FROM movies WHERE RANK >0.01 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnStarringField) to '/home/pi/RSL/top50recommendationsOnStarringINCEPTION.csv' WITH csv;
