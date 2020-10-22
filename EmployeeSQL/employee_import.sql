
-- CREATING TABLES

CREATE TABLE departments(
	dept_no VARCHAR(30) PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL
);

Create TABLE titles (
	title_id VARCHAR(30) PRIMARY KEY,
	titles VARCHAR(30) NOT NULL 
);

CREATE TABLE salaries (
	emp_no INTEGER PRIMARY KEY,
	salary INTEGER NOT NULL
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(30) NOT NULL,
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES salaries (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR(30) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE employees(
	emp_no INTEGER NOT NULL,
	emp_title VARCHAR(30) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(30) NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
	FOREIGN KEY (emp_title) REFERENCES titles (title_id)
);


-- Load Tables?

SELECT * FROM departments LIMIT 1;
SELECT * FROM titles LIMIT 1;
SELECT * FROM salaries LIMIT 1;
SELECT * FROM dept_manager LIMIT 1;
SELECT * FROM dept_emp LIMIT 1;
SELECT * FROM employees LIMIT 1;

-- Query employee number, last name, first name, sex, and salary
SELECT e.emp_no AS employee_number,
	e.last_name,
	e.first_name,
	e.sex,
	s.salary
FROM employees e
JOIN salaries s
ON s.emp_no = e.emp_no;

-- Query first name, last name, and hire date for employees who were hired in 1986
SELECT e.emp_no AS employee_number,
		e.last_name,
		e.first_name,
		e.sex,
		s.salary
FROM employees e
JOIN salaries s
ON s.emp_no = e.emp_no;

-- Query first name, last name, and hire date for employees who were hired -> 1986
SELECT first_name,
		last_name,
		hire_date
FROM employees
WHERE date_part('year', hire_date) = 1986;

-- Query manager of each dept. with: department number, department name, the manager's employee number, last name, first name
SELECT dm.dept_no AS department_number,
		d.dept_name AS department,
		dm.emp_no AS manager_employee_number,
		e.last_name,
		e.first_name
FROM dept_manager dm
JOIN departments d
ON d.dept_no = dm.dept_no
INNER JOIN employees e
ON e.emp_no = dm.emp_no;

-- Query dept. for each employee with: employee number, last name, first name, and department name
SELECT e.emp_no AS employee_number,
	e.last_name,
	e.first_name,
	d.dept_name AS department_name
FROM employees e
INNER JOIN dept_emp de
ON de.emp_no = e.emp_no
INNER JOIN departments d
ON d.dept_no = de.dept_no;

-- Query first name, last name, and sex for employee whose first anem is "Hercules" and last name begins with "B"
SELECT last_name,
		first_name,
		sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- Query employees in Sales, including employee number, last name, first name, and department name
CREATE VIEW employee_queries AS
SELECT e.emp_no AS employee_number,
		e.last_name,
		e.first_name,
		d.dept_name AS department_name
FROM employees e
INNER JOIN dept_emp de
ON de.emp_no = e.emp_no
INNER JOIN departments d
ON d.dept_no = de.dept_no;

SELECT *
FROM employee_queries
WHERE department_name = 'Sales';

-- Query employees in Sales and Development epartments with: employee number, last name, first name, and department name
SELECT last_name,
			COUNT(last_name) AS frequency_count
FROM employee_queries
GROUP BY 1
ORDER BY 2 DESC;

