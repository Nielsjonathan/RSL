/*The table is created*/
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
/*The data is loaded into the table*/
\copy movies FROM '/home/pi/RSL/moviesFromMetacritic.csv' delimiter ';' csv header ;
