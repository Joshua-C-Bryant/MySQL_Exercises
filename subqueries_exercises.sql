USE employees;

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager
)
LIMIT 10;

SELECT *
FROM employees
WHERE emp_no = '101010';


#exercise 1 Find all the current employees with the same hire date as employee 101010 using a sub-query

SELECT *
FROM employees
WHERE hire_date IN (
	SELECT hire_date
	FROM employees
	WHERE emp_no = '101010')
	AND emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > now());

#exercise 2 Find all the titles ever held by all current employees with the first name Aamod

SELECT *
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod')
AND to_date > now();

#exercise 3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code

SELECT COUNT(*) as "Employees no longer working"
FROM employees
WHERE emp_no IN(
	SELECT emp_no
	FROM titles
	WHERE to_date < now());
# 188132 employees 

#exercise 4 Find all the current department managers that are female. List their names in a comment in your code

SELECT *
FROM employees
WHERE emp_no IN(
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > now())
AND gender = 'F';
#Isamu Legleitner, Karsten Sigstam, Leon DassSarma, Hilart Kambil

#exercise 5 Find all the employees who currently have a higher salary than the companies overall, historical average salary
SELECT *
FROM employees
WHERE emp_no IN(
	SELECT emp_no
	FROM salaries
	WHERE salary > (select avg(salary) from salaries)
	AND to_date > now());

#exercise 6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT COUNT(*) AS "Number of Employees Making More Than 1 SD"
FROM employees
WHERE emp_no IN(
	SELECT emp_no
	FROM salaries
	WHERE salary > (select stddev(salary))
	AND to_date > now());
	
	
	
	