USE albums_db;

DESCRIBE albums;

#31 rows
SELECT * FROM albums;

#23 artists
SELECT DISTINCT artist
FROM albums;

#primary key is id

#oldest album = 1967
SELECT *
FROM albums
ORDER BY release_date ASC;

#most recent album = 2011
SELECT *
FROM albums
ORDER BY release_date DESC;

#name of all albums by Pink Floyd
SELECT name
FROM albums
WHERE artist = 'Pink Floyd';

#year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts CLub Band";

#genre for album Nevermind
SELECT genre
FROM albums
WHERE name = 'Nevermind';

#albums released in the 90's
SELECT name
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

#albums with < 20 mil sales
SELECT name
FROM albums
WHERE sales <= 20;

#albums with the genre "Rock"
SELECT name
FROM albums
WHERE genre LIKE "%rock%"



