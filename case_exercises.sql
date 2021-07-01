-- case_exercises --

-- exercise 1 Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT
	CONCAT(first_name, ' ', last_name) AS 'Employee Name',
	dept_no AS 'Department Number', 
	from_date AS 'Start Date',
	to_date AS 'End Date', 
	IF(to_date > now(),1,0) AS 'Is Current Employee'
FROM dept_emp
JOIN (SELECT emp_no, MAX(to_date) AS max_date
		FROM dept_emp
		GROUP BY emp_no) AS last_dept
		ON dept_emp.emp_no = last_dept.emp_no 
		AND dept_emp.to_date = last_dept.max_date
JOIN employees ON employees.emp_no = dept_emp.emp_no;



-- exercise 2 Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT
	CONCAT(first_name, ' ', last_name) AS 'Employee Name',
	CASE
		WHEN SUBSTR(last_name,1,1) IN ('A','B','C','D','E','F','G','H') THEN 'A-H'
		WHEN SUBSTR(last_name,1,1) IN ('I','J','K','L','M','N','O','P','Q') THEN 'I-Q'
		ELSE 'R-Z'
		END AS alpha_group
FROM employees;

-- exercise 3 How many employees (current or previous) were born in each decade?

SELECT
	COUNT(CASE WHEN birth_date LIKE '195%' THEN birth_date ELSE NULL END) AS "Born in the 50's",
	COUNT(CASE WHEN birth_date LIKE '196%' THEN birth_date ELSE NULL END) AS "Born in the 60's"
FROM employees;

-- bonus What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT 
	CASE
		WHEN dept_name IN ('Customer Service') THEN "Customer Service"
		WHEN dept_name IN ('Finance', 'Human Resources') THEN "Finance & HR"
		WHEN dept_name IN ('Sales', 'Marketing') THEN "Sales & Marketing"
		WHEN dept_name IN ('Production', 'Quality Management') THEN "Prod & QM"
		WHEN dept_name IN ('Research', 'Development') THEN "R&D"
		END as dept_group,
	AVG(salary) as avg_sal
FROM salaries
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE salaries.to_date > now()
GROUP BY dept_group
ORDER BY dept_group;








