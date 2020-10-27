ALTER TABLE movies
ADD lexemesTitle tsvector;
UPDATE movies
SET lexemesTitle = to_tsvector(title);
SELECT url FROM movies WHERE lexemesTitle @@ to_tsquery('inception');
ALTER TABLE movies
ADD rank float4;
UPDATE movies
SET rank = ts_rank(lexemesTitle,plainto_tsquery((SELECT title FROM movies WHERE url='inception')));
CREATE TABLE recommendationsBasedOnTitleField AS SELECT url, rank FROM movies WHERE RANK >0.01 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnTitleField) to '/home/pi/RSL/top50recommendationsOnTitleINCEPTION.csv' WITH csv;
