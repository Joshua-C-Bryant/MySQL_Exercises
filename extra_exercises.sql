-- More MySQL Exercises -- 

-- Employees Database --

USE employees;

-- exercise #1 How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary? --

SELECT first_name, last_name, salary, dept_name 
FROM employees
JOIN dept_manager using(emp_no)
JOIN salaries using(emp_no)
JOIN departments using(dept_no)
JOIN dept_emp using(emp_no)
WHERE salaries.to_date > now()
AND dept_manager.to_date > now()
GROUP BY first_name, last_name, salary, dept_name;

