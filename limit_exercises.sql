USE employees;

SELECT DISTINCT title
FROM titles;

#exercise 2
SELECT DISTINCT last_name
FROM employees
LIMIT 10;

#exercise 3
SELECT *
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31')
	AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5;
#First 5 = Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, and Petter Stroustrup

#exercise 4
SELECT *
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31')
	AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45