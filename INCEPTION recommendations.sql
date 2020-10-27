ALTER TABLE movies
ADD lexemesSummary tsvector;
UPDATE movies
SET lexemesSummary = to_tsvector(Summary);
SELECT url FROM movies WHERE lexemesSummary @@ to_tsquery('inception');
ALTER TABLE movies
ADD rank float4;
UPDATE movies
SET rank = ts_rank(lexemesSummary,plainto_tsquery((SELECT Summary FROM movies WHERE url='inception')));
DROP TABLE recommendationsBasedOnSummaryField;
CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank FROM movies WHERE RANK >0.01 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnSummaryField) to '/home/pi/RSL/top50recommendationsINCEPTION.csv' WITH csv;
