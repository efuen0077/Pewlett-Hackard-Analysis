-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);


CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);


CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);


CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);


CREATE TABLE titles (
emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

DROP TABLE dept_emp CASCADE;

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
    dept_no VARCHAR(5) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM departments;

SELECT * FROM departments

-- import dept_manager
SELECT * FROM dept_manager

-- now let's import employees
SELECT * FROM employees

-- import salaries
SELECT * FROM salaries

--import titles
SELECT * FROM titles

--import dept_emp
SELECT * FROM dept_emp



SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


--Pewlett Hackard has a lot of employees getting ready
--to age out of the program. This is going to create a
--considerable amount of openings. Refine this list
--further by looking only at how many employees were
--born in 1952. Create another query that will search
--for only 1952 birth dates.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


--search for employees who were born in 1953,
--1954, and 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';




SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';


--Narrow the search for retirement eligibility
-- Retirement eligibility
-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');




-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


--Original Query that we will be Modifying
--SELECT first_name, last_name
--FROM employees
--WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;



--code for inner join
--inner join
-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;


DROP current_emp;
--current employees who are eligible for retirement
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date	
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
SELECT * FROM current_emp;

--join the current_emp and dept_emp tables.
-- count the amount of emps per dept
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO current_emp_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
SELECT * FROM current_emp_dept;

SELECT * FROM salaries
ORDER BY to_date DESC;

--new tables
--1.  Employee Information
--Employee Information: A list of employees containing
--their unique employee number, their last name,
--first name, gender, and salary
SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info


-- 2. Management

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
SELECT * FROM manager_info


--Department Retirees

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
-- INTO dept_info
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT * FROM dept_info

-----------------------------------------------------------------------------------------------------------------------

--Table 1 for Challenge
--Number of Retiring Employees ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--we filtered employee data earlier --> 1952 to 1955
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');
--AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT * FROM retirement_info

DROP TABLE retirement_info;

SELECT ri.emp_no,
ri.first_name,
ri.last_name,
ti.title,
s.from_date,
s.salary
INTO retiring_emp_data
FROM retirement_info AS ri
	INNER JOIN salaries AS s
		ON (ri.emp_no = s.emp_no)
	INNER JOIN titles AS ti
		ON (s.from_date = ti.from_date)
order by ri.emp_no;
SELECT * FROM retiring_emp_data

---get rid of the duplicates
SELECT DISTINCT emp_no, first_name, last_name, title, from_date, salary
FROM retiring_emp_data;

--DROP TABLE retiring_emp_data;


-- Partition the data to show only most recent title per employee
SELECT emp_no,
first_name,
last_name,
title,
from_date,
salary
INTO new_retiring_emp_info
FROM
 (SELECT emp_no,
first_name,
last_name,
title,
from_date,
  salary,
  ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM retiring_emp_data
 ) tmp WHERE rn = 1
ORDER BY emp_no;
DROP TABLE new_retiring_emp_info;
SELECT * FROM new_retiring_emp_info

SELECT COUNT(first_name)
FROM new_retiring_emp_info;

-- table showing how many retiring employees there are per title
SELECT COUNT(nrei.emp_no), nrei.title
INTO retiring_emp_title
FROM new_retiring_emp_info as nrei
GROUP BY nrei.title
ORDER BY nrei.title;
SELECT * FROM retiring_emp_title;

---------------------------------------------------------
--Table 2: Mentorship Eligibility
--date of birth that falls between January 1, 1965 and December 31, 1965.
SELECT emp_no, first_name, last_name
INTO eligibility_info
FROM employees
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31');
DROP TABLE eligibility_info;
SELECT * FROM eligibility_info

--TWO INNER JOINS
SELECT ei.emp_no,
ei.first_name,
ei.last_name,
ti.title,
s.from_date,
s.to_date
INTO new_eligibility_info
FROM eligibility_info AS ei
	INNER JOIN salaries AS s
		ON (ei.emp_no = s.emp_no)
	INNER JOIN titles AS ti
		ON (s.from_date = ti.from_date)
order by ei.emp_no;
SELECT * FROM new_eligibility_info

---get rid of the duplicates
SELECT DISTINCT emp_no, first_name, last_name, title, from_date, to_date
INTO final_eligibility_info
FROM new_eligibility_info;
SELECT * FROM final_eligibility_info

SELECT COUNT(first_name)
FROM new_eligibility_info;