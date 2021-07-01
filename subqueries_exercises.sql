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
WHERE hire_date IN ( -- setting up our hire_date filter
	SELECT hire_date
	FROM employees
	WHERE emp_no = '101010') -- which employee do we want to match?
	AND emp_no IN (
		SELECT emp_no
		FROM dept_emp
		WHERE to_date > now()); -- filter for current employees

#exercise 2 Find all the titles ever held by all current employees with the first name Aamod


# REVISIT THIS
SELECT DISTINCT * -- we want all titles
FROM titles
WHERE emp_no IN ( -- linking titles and employees through emp_no
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod') AND emp_no IN(
		SELECT emp_no
		FROM dept_emp
		WHERE to_date > now()); -- filtering name 'Aamod'

#exercise 3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code

SELECT COUNT(*) as "Employees no longer working"
FROM employees
WHERE emp_no NOT IN(
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > now());
# 59900 employees 

#exercise 4 Find all the current department managers that are female. List their names in a comment in your code

SELECT
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

SELECT (SELECT COUNT(salary)
FROM salaries
WHERE salaries.to_date > now() 
AND salary >= (SELECT MAX(salary)FROM salaries WHERE salaries.to_date > now()) 
- (SELECT STD(salary) FROM salaries WHERE salaries.to_date > now()))/
(SELECT COUNT(salary)
FROM salaries
WHERE salaries.to_date> now())*100 AS "Percentage of salaries within 1 standard deviation of current highest salary";

#bonus 1 Find all the department names that currently have female managers
SELECT dept_name AS "Departments that currently have Female Managers"
FROM departments
WHERE dept_no IN(
	SELECT dept_no
	FROM dept_manager
	WHERE emp_no IN(
		SELECT emp_no
		FROM employees
		WHERE gender ='F') AND to_date > now());

#bonus 2 Find the first and last name of the employee with the highest salary
SELECT concat(first_name, " ", last_name) as "Highest Paid Employee"
FROM employees
WHERE emp_no IN(
	SELECT emp_no
	FROM salaries 
	WHERE salary = (SELECT MAX(salary) FROM salaries));
	
#bonus 3 Find the department name that the employee with the highest salary works in
SELECT dept_name
FROM departments
WHERE dept_no IN(
	SELECT dept_no
	FROM dept_emp
	WHERE emp_no IN(
		SELECT emp_no
		FROM salaries
		WHERE salary = (SELECT MAX(salary) FROM salaries)));
	




	