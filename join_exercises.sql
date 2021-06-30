#Join Example Database

USE join_example_db;

# exercise 2 Using join, left join, and right join
SELECT *
FROM users
JOIN roles ON roles.id = users.role_id;

SELECT *
FROM users
LEFT JOIN roles ON roles.id = users.role_id;

SELECT *
FROM users
RIGHT JOIN roles ON roles.id = users.role_id;

SELECT * #playing around with positioning here
FROM roles
RIGHT JOIN users ON users.role_id = roles.id;

#exercise 3 Use count
SELECT COUNT(users.role_id) as number_of_employees,
	roles.name
FROM users
RIGHT JOIN roles ON roles.id = users.role_id
GROUP BY role_id, roles.name;

#Employees Database

USE employees;

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;

#exercise 2 Show each department along with name of current manager
SELECT dept_name AS 'Department Name',
CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM dept_manager
JOIN departments ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE to_date > curdate()
ORDER BY dept_name;

#exercise 3 Find the name of all departments currently managed by women
SELECT dept_name AS 'Department Name',
CONCAT(first_name, ' ', last_name) AS 'Manager Name'
FROM dept_manager
JOIN departments ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE to_date > curdate() AND employees.gender = 'F'
ORDER BY dept_name;

#exercise 4 Find the current titles of employees currently working in the Customer Service department
SELECT title AS 'Title', COUNT(titles.emp_no) AS 'Count'
FROM dept_emp
JOIN titles ON titles.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE titles.to_date > curdate() 
	AND dept_emp.to_date > curdate() 
	AND departments.dept_name = 'Customer Service'
GROUP BY title
ORDER BY title ASC;

#exercise 5 Find the current salary of all current managers
SELECT dept_name AS 'Department Name',
	CONCAT(first_name, ' ', last_name) AS 'Name',
	salaries.salary AS 'Salary'
FROM dept_manager
JOIN departments ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN salaries ON salaries.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date > curdate() AND salaries.to_date > curdate()
ORDER BY dept_name;

#exercise 6 Find the number of current employees in each department
SELECT dept_no, dept_name, COUNT(dept_emp.emp_no) AS num_employees
FROM departments
JOIN dept_emp using(dept_no)
WHERE to_date > curdate()
GROUP BY dept_no
ORDER BY dept_no;

#exercise 7 Which department has the highest average salary? Hint: Use current not historic information
SELECT dept_name, AVG(salary) as average_salary
FROM salaries
JOIN dept_emp using(emp_no)
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date > curdate() AND salaries.to_date > curdate()
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

#exercise 8 Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name
FROM employees
JOIN dept_emp using(emp_no) -- connects department to employee
JOIN salaries using(emp_no) -- connects salary to employee
JOIN departments using(dept_no) -- so we know what department to filter
WHERE departments.dept_name = 'Marketing'-- what department we want
AND salaries.to_date > curdate() -- current salaries
AND dept_emp.to_date > curdate() -- current employees
ORDER BY salary DESC -- highest paid
LIMIT 1;

#exercise 9 Which current department manager has the highest salary?
SELECT first_name, last_name, salary, dept_name
FROM dept_manager
JOIN employees using(emp_no)
JOIN departments using(dept_no)
JOIN salaries using(emp_no)
JOIN dept_emp using(emp_no)
WHERE dept_manager.to_date > curdate()
ORDER BY salary DESC
LIMIT 1;

#exercise 10 Bonus Find the names of all current employees, their department name, and their current manager's name
SELECT CONCAT(e.first_name, " ", e.last_name) AS "Employee Name",
	d.dept_name as "Department Name",
	CONCAT(e1.first_name, " ", e1.last_name) as "Manager Name"
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no -- link employee numbers
JOIN departments d ON d.dept_no = de.dept_no -- link the dept num
JOIN dept_manager dm ON dm.dept_no = de.dept_no -- link the managers to the dept num
JOIN employees e1 ON e1.emp_no = dm.emp_no -- using employees under alias 'e1' to get manager name
WHERE de.to_date > curdate() AND dm.to_date > curdate();
	
	
-- Code for bonus question 11 --	
SELECT 
	t1.dept_name AS 'Department Name',
	t1.salary AS 'Salary',
	CONCAT(first_name,' ', last_name) AS 'Employee Name'
FROM 
	(
	-- Part 1 which builds the base table to employee names, salaries and dept names
	SELECT
		salary, dept_name, first_name, last_name
	FROM
		salaries
	JOIN
		dept_emp 
	USING(emp_no)
	JOIN 
		departments 
	USING(dept_no)
	JOIN 
		employees
	USING(emp_no)
	WHERE 
		dept_emp.to_date >= NOW()
	AND 
		salaries.to_date >= NOW()
	) AS t1 # This is table_1 result created
INNER JOIN
	(
	-- Part 2 builds another table to cross reference the previous part with the calculated max salaries
	SELECT dept_name, MAX(salary) as max_salary
	FROM 
		(
		SELECT
			salary, dept_name, first_name, last_name
		FROM
			salaries
		JOIN
			dept_emp 
		USING(emp_no)
		JOIN 
			departments 
		USING(dept_no)
		JOIN 
			employees
		USING(emp_no)
		WHERE 
			dept_emp.to_date >= NOW()
			AND 
			salaries.to_date >= NOW()
		) as t2
	GROUP BY dept_name
	) AS t2 # This is table_2 result created
	-- Joins both tables based on the dept_name and matches the salary & department name with the max_salary
	ON 
	t1.dept_name = t2.dept_name
	AND
	t1.salary = t2.max_salary
ORDER BY 'Department Name' DESC;
