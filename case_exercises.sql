-- case_exercises --

-- exercise 1 Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT
	CONCAT(first_name, ' ', last_name) AS 'Employee Name',
	dept_no AS 'Department Number', 
	from_date AS 'Start Date',
	to_date AS 'End Date', 
	to_date > now() = 'is_current_employee' AS 'Is Current Employee'
FROM dept_emp
JOIN employees USING(emp_no);
	
-- exercise 2 Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT
	CONCAT(first_name, ' ', last_name) AS 'Employee Name',
	CASE
		WHEN last_name LIKE 'A%' THEN 'A-H'
		WHEN last_name LIKE 'B%' THEN 'A-H'
		WHEN last_name LIKE 'C%' THEN 'A-H'
		WHEN last_name LIKE 'D%' THEN 'A-H'
		WHEN last_name LIKE 'E%' THEN 'A-H'
		WHEN last_name LIKE 'F%' THEN 'A-H'
		WHEN last_name LIKE 'G%' THEN 'A-H'
		WHEN last_name LIKE 'H%' THEN 'A-H'
		WHEN last_name LIKE 'I%' THEN 'I-Q'
		WHEN last_name LIKE 'J%' THEN 'I-Q'
		WHEN last_name LIKE 'K%' THEN 'I-Q'
		WHEN last_name LIKE 'L%' THEN 'I-Q'
		WHEN last_name LIKE 'M%' THEN 'I-Q'
		WHEN last_name LIKE 'N%' THEN 'I-Q'
		WHEN last_name LIKE 'O%' THEN 'I-Q'
		WHEN last_name LIKE 'P%' THEN 'I-Q'
		WHEN last_name LIKE 'Q%' THEN 'I-Q'
		WHEN last_name LIKE 'R%' THEN 'R-Z'
		WHEN last_name LIKE 'S%' THEN 'R-Z'
		WHEN last_name LIKE 'T%' THEN 'R-Z'
		WHEN last_name LIKE 'U%' THEN 'R-Z'
		WHEN last_name LIKE 'V%' THEN 'R-Z'
		WHEN last_name LIKE 'W%' THEN 'R-Z'
		WHEN last_name LIKE 'X%' THEN 'R-Z'
		WHEN last_name LIKE 'Y%' THEN 'R-Z'
		WHEN last_name LIKE 'Z%' THEN 'R-Z'
		ELSE 'Other'
		END AS alpha_group
FROM employees;

-- exercise 3 How many employees (current or previous) were born in each decade?

SELECT
	COUNT(CASE WHEN birth_date LIKE '195%' THEN birth_date ELSE NULL END) AS "Born in the 50's",
	COUNT(CASE WHEN birth_date LIKE '196%' THEN birth_date ELSE NULL END) AS "Born in the 60's",
	COUNT(CASE WHEN birth_date LIKE '197%' THEN birth_date ELSE NULL END) AS "Born in the 70's",
	COUNT(CASE WHEN birth_date LIKE '198%' THEN birth_date ELSE NULL END) AS "Born in the 80's",
	COUNT(CASE WHEN birth_date LIKE '199%' THEN birth_date ELSE NULL END) AS "Born in the 90's"
FROM employees;

-- bonus What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT
	dept_name
JOIN dept_emp USING(dept_no)
JOIN AVG(salary.salaries USING(emp_no)
FROM departments;






