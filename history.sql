SELECT
	name,
	genre
FROM albums
where genre like "%rock%";
#Exercise 4d
SELECT
	name
FROM albums
WHERE release_date between 1990 and 1999;
SELECT *
FROM albums;
#Exercise 4f
SELECT
	name
FROM albums
WHERE genre CONTAINS 'Rock';
#Exercise 4f
SELECT
	name
FROM albums
WHERE genre = 'Rock';
--Exercise 4a--
SELECT
	name
FROM albums
WHERE genre like 'Rock';
SELECT
	name
FROM albums
WHERE genre like 'Rock';
SELECT
	name
FROM albums
WHERE genre IN 'Rock';
SELECT
	name
FROM albums
WHERE sales < 20;
SELECT
	name
FROM albums
WHERE release_date = '1990';
SELECT MIN(release_date)
FROM albums;
SELECT
	genre
FROM albums
WHERE name = 'Nevermind';
SELECT
	release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band"

SELECT
	genre
FROM albums
WHERE name = 'Nevermind';
SELECT
	release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
SELECT MAX (release_date)
FROM albums;
SELECT MAXVALUE (release_date)
FROM albums;
SELECT MAXVALUE (release_date);
SELECT MAX (release_date);
SELECT release_date
FROM albums
ORDER BY release_date ASC;
SELECT release_date
FROM albums
ORDER BY ASC