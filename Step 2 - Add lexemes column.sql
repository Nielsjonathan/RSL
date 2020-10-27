/*The column lexemesSummary is added to the table*/
ALTER TABLE movies
ADD lexemesSummary tsvector;
/*The table is updated and the column lexemesSummary is filled*/
UPDATE movies
SET lexemesSummary = to_tsvector(Summary);
