ALTER TABLE movies
ADD lexemesSummary tsvector;
UPDATE movies
SET lexemesSummary = to_tsvector(Summary);
SELECT url FROM movies WHERE lexemesSummary @@ to_tsquery('race');
ALTER TABLE movies
ADD rank float4;
UPDATE movies
SET rank = ts_rank(lexemesSummary,plainto_tsquery((SELECT Summary FROM movies)));
CREATE TABLE recommendationsBasedOnSummaryField1 AS SELECT url, rank FROM movies WHERE RANK >0.01 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnSummaryField1) to '/home/pi/RSL/top50recommendationsRace.csv' WITH csv;