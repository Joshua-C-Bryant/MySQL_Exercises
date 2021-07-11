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

ALTER TABLE employees_with_departments MODIFY full_name VARCHAR(100);

DESCRIBE employees_with_departments;

UPDATE employees_with_departments 
SET full_name = CONCAT(first_name, ' ', last_name);

ALTER TABLE employees_with_departments DROP column first_name;
ALTER TABLE employees_with_departments DROP column last_name;


-- exercise #2 Create a temporary table based on the payment table from the sakila database.

-- COME BACK TO THIS, CENTS ARE ROUNDING UP...SELECT CAST (amount as INT)

USE germain_1456;

CREATE TEMPORARY TABLE cents AS
SELECT payment_id, customer_id, staff_id, rental_id, amount * 100 as amount_in_pennies, payment_date, last_update
FROM sakila.payment;

SELECT *
FROM cents;

DESCRIBE cents;


ALTER TABLE cents MODIFY COLUMN amount_in_pennies INT;


SELECT *
FROM cents;

-- exercise #3 Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?


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

USE germain_1456;

SELECT AVG(salary), std(salary) FROM employees.salaries;

-- Saving values for later
CREATE TEMPORARY TABLE historic_aggregates AS (
    SELECT AVG(salary) AS avg_salary, std(salary) AS std_salary
    FROM employees.salaries);


SELECT * FROM historic_aggregates;


SELECT dept_name, AVG(salary) AS department_current_average
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.dept_emp.to_date > curdate()
AND employees.salaries.to_date > curdate()
GROUP BY dept_name;


CREATE TEMPORARY TABLE current_info AS (
    SELECT dept_name, AVG(salary) AS department_current_average
    FROM employees.salaries
    JOIN employees.dept_emp USING(emp_no)
    JOIN employees.departments USING(dept_no)
    WHERE employees.dept_emp.to_date > curdate()
    AND employees.salaries.to_date > curdate()
    GROUP BY dept_name
);

SELECT * FROM current_info;

-- add on all the columns we'll end up needing:
ALTER TABLE current_info ADD historic_avg FLOAT(10,2);
ALTER TABLE current_info ADD historic_std FLOAT(10,2);
ALTER TABLE current_info ADD zscore FLOAT(10,2);

SELECT * FROM current_info;

-- set the avg and std
UPDATE current_info SET historic_avg = (SELECT avg_salary FROM historic_aggregates);
UPDATE current_info SET historic_std = (SELECT std_salary FROM historic_aggregates);

SELECT * FROM current_info;

-- update the zscore to hold the calculated zscores
UPDATE current_info 
SET zscore = (department_current_average - historic_avg) / historic_std;

SELECT * FROM current_info
ORDER BY zscore DESC;







 

