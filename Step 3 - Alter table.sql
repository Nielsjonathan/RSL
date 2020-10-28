/*The column rank is added to the table*/
ALTER TABLE movies
ADD COLUMN IF NOT EXISTS rank1 float4;
ALTER TABLE movies
ADD COLUMN IF NOT EXISTS rank2 float4;
ALTER TABLE movies
ADD COLUMN IF NOT EXISTS rank3 float4;
/*The table is updated and the column rank is filled*/
UPDATE movies
SET rank1 = ts_rank(lexemesSummary,plainto_tsquery(
(SELECT Summary FROM movies WHERE url='inception')
));
UPDATE movies
SET rank2 = ts_rank(lexemesSummary,plainto_tsquery(
(SELECT title FROM movies WHERE url='inception')
));
UPDATE movies
SET rank3 = ts_rank(lexemesSummary,plainto_tsquery(
(SELECT Starring FROM movies WHERE url='inception')
));
