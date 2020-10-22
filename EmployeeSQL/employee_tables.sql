
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

