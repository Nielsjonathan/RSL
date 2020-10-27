/*The column rank is added to the table*/
ALTER TABLE movies
ADD rank float4;
/*The table is updated and the column rank is filled*/
UPDATE movies
SET rank = ts_rank(lexemesSummary,plainto_tsquery(
(SELECT Summary FROM movies WHERE url='inception')
));
