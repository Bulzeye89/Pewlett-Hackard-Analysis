--Create retirement titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date, 
	ti.to_date
INTO retirement_titles
FROM employees as e
	INNER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--Check table before exporting
SELECT * FROM retirement_titles;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC, title DESC ;

--Check table before exporting
SELECT * FROM unique_titles;


--Create retiring titles table
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT (title) DESC;

--Check table before exporting
SELECT * FROM retiring_titles;

--create mentorship eligibility table 
SELECT DISTINCT ON (e.emp_no)
	e.emp_no, 
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date, 
	ti.title
INTO mentorship_eligibility
FROM employees AS e
	LEFT JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
	LEFT JOIN titles AS ti
		ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY  e.emp_no;

--check table before exporting
SELECT * FROM mentorship_eligibility;
