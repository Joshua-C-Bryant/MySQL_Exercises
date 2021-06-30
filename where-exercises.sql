
#exercise 1
USE employees;

#exercise 2 
DESCRIBE employees;

#709 employees with first names Irena, Vidya, or Maya
SELECT *
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya');

#exercise 3
SELECT *
FROM employees
WHERE first_name = 'Irena' 
	OR first_name = 'Vidya' 
	OR first_name = 'Maya';
#709 employees with first names Irena, Vidya, or Maya

#exercise 4
SELECT *
FROM employees
WHERE (first_name = 'Irena' 
	OR first_name = 'Vidya' 
	OR first_name = 'Maya')
	AND gender = 'M';
#441 first names Irena, Vidya, or Maya and male

#exercise 5
SELECT *
FROM employees
WHERE last_name LIKE "E%";
#7330 employees whose last name starts with E 

#exercise 6
SELECT *
FROM employees
WHERE last_name LIKE "E%" OR last_name LIKE "%E";
#30723 employees whose last name starts or ends with E

SELECT *
FROM employees
WHERE last_name LIKE "%E" AND last_name NOT LIKE "E%";
#23393 employees that have a last name that ends with E but does not start with E

#exercise 7
SELECT *
FROM employees
WHERE last_name LIKE "E%E";
#899 employees with a last name that starts and ends with E

SELECT *
FROM employees
WHERE last_name LIKE "%E";
#24292 employees last name ends with E

#exercise 8
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
#135214 employees hired in the 90s

#exercise 9
SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25';
#842 employees born on Christmas

#exercise 10
SELECT *
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31')
	AND birth_date LIKE '%%%%-12-25';
#362 employees hired in the 90s and born on Christmas

#exercise 11
SELECT *
FROM employees
WHERE last_name LIKE '%q%';
#1873 employees with 'q' in their last name

#exercise 12
SELECT *
FROM employees 
WHERE last_name LIKE '%q%' AND NOT last_name LIKE '%qu%'
#547 employees with last name containing 'q' but not 'qu'