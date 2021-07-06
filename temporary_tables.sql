-- temporary_tables exercises --

-- exercises #1 Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- Update the table so that full name column contains the correct data
-- Remove the first_name and last_name columns from the table.
-- What is another way you could have ended up with this same table?

USE germain_1456;

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);


SELECT *
FROM employees_with_departments;

ALTER TABLE employees_with_departments MODIFY full_name VARCHAR(100); -- changed 'add' to 'modify' to fix my error

DESCRIBE employees_with_departments;

UPDATE employees_with_departments 
SET full_name = CONCAT(first_name, ' ', last_name);

ALTER TABLE employees_with_departments DROP column first_name;
ALTER TABLE employees_with_departments DROP column last_name;


-- exercise #2 Create a temporary table based on the payment table from the sakila database.

-- COME BACK TO THIS, CENTS ARE ROUNDING UP...SELECT CAST (amount as INT)

USE germain_1456;

CREATE TEMPORARY TABLE cents AS
SELECT *
FROM sakila.payment;

SELECT *
FROM cents;

DESCRIBE cents;

ALTER TABLE cents MODIFY COLUMN amount INT;

UPDATE cents SET amount = amount * 100;

SELECT *
FROM cents;

-- exercise #3 (NOT FINISHED) Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?


USE employees;

SELECT dept_name,AVG(salary) AS current_average_salary -- this is the current avg salary with dept listed
FROM employees
JOIN salaries USING(emp_no)
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE salaries.to_date > now()
GROUP BY dept_name
ORDER BY dept_name;

SELECT AVG(salary) 
FROM salaries; -- overall, historical avg salary

select salary, salary - (select avg(salary) from salaries) as "numerator",
(select std(salary) from salaries) as "denominator"
from salaries;


USE germain_1456;

select avg(salary), std(salary) from employees.salaries;



CREATE TEMPORARY TABLE germain_1456.zscore AS
SELECT dept_name, AVG(salary) AS current_average_salary
FROM employees.salaries
JOIN employees.dept_emp ON dept_emp.emp_no = salaries.emp_no AND dept_emp.to_date > now() AND salaries.to_date > now()
JOIN employees.departments ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date > now()
GROUP BY dept_name;

SELECT *
FROM germain_1456.zscore;

ALTER TABLE germain_1456.zscore ADD zscore float(10,3);

UPDATE germain_1456.zscore SET zscore =
((AVG(salary) - (
SELECT AVG(salary) FROM employees.salaries))/(SELECT STDDEV(salaries.salary) FROM employees.salaries));








