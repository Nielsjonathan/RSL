/*The columns lexemesSummary, lexemesTitle and lexemesStarring are added to the table*/
ALTER TABLE movies
ADD COLUMN IF NOT EXISTS lexemesSummary tsvector;
ALTER TABLE movies
ADD COLUMN IF NOT EXISTS lexemesTitle tsvector;
ALTER TABLE movies
ADD COLUMN IF NOT EXISTS lexemesStarring tsvector;
/*The table is updated and the columns lexemesSummary, lexemesTitle and lexemesStarring are filled*/
UPDATE movies
SET lexemesSummary = to_tsvector(Summary), lexemestitle = to_tsvector(title), lexemesStarring = to_tsvector(Starring);
