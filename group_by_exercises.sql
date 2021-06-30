USE employees;

#exercise 2
SELECT DISTINCT title
FROM titles;
#7 unique titles

#exercise 3
SELECT last_name
FROM employees
WHERE last_name LIKE "E%E"
GROUP BY last_name;

#exercise 4
SELECT 
	first_name,
	last_name
FROM employees
WHERE last_name LIKE "E%E"
GROUP BY first_name, last_name;

#exercise 5
SELECT last_name
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%"
GROUP BY last_name;
#Chleq, Lindqvist, Qiwen
	
#exercise 6
SELECT 
	last_name,
	COUNT(*) AS number_of_employees
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%"
GROUP BY last_name;
#Chleq 189, Lindqvist 190, Qiwen 168

#exercise 7
SELECT
	first_name,
	gender,
	COUNT(gender) AS number_of_employees
FROM employees
WHERE first_name = "Irena"
	OR first_name = "Vidya"
	OR first_name = "Maya"
GROUP BY first_name, gender;

#exercise 8
SELECT
LOWER(CONCAT(
substr(first_name,1,1),
substr(last_name,1,4),
"_",
substr(birth_date,6,2),
substr(birth_date,3,2))) as username,
COUNT(*) as number_of_usernames
FROM employees
GROUP BY username
HAVING COUNT(username) > 1;
#13251 duplicates
	
	
	