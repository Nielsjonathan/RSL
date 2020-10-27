CREATE TABLE movies (url text,
title text,
ReleaseDate text,
Distributor text,
Starring text,
Summary text,
Director text,
Genre text,
Rating text,
Runtime text,
Userscore text,
Metascore text,
scoreCounts text
);

\copy movies FROM '/home/pi/RSL/moviesFromMetacritic.csv' delimiter ';' csv header ;


ALTER TABLE movies
ADD lexemesSummary tsvector;

UPDATE movies
SET lexemesSummary = to_tsvector(Summary);

ALTER TABLE movies
ADD rank float4;

UPDATE movies
SET rank = ts_rank(lexemesSummary,plainto_tsquery(
(SELECT Summary FROM movies WHERE url='inception')
));

CREATE TABLE recommendationsSummary AS 
SELECT url, rank FROM movies WHERE rank > 0.01 ORDER BY rank DESC LIMIT 50;

\COPY (SELECT * FROM recommendationsSummary)
TO '/home/pi/RSL/recommendationsSummary.csv' WITH csv;


