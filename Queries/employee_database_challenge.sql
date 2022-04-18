CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR(60) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (emp_no, title, from_date)
);

-- retrieve columns from employees table
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO data_titles
FROM employees as ce
	INNER JOIN titles AS ti
ON (ce.emp_no = ti.emp_no)
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY ce.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM data_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no ASC, last_name DESC;


-- Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.emp_no),
ut.title
INTO retiring_titles_employees
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;
