-- Deliverable 1: The Number of Retiring Employees by Title (50 points)
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
ON (e.emp_no=t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no ASC;

select * from retirement_titles where emp_no = '10011';

drop table unique_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

select * from unique_titles;

-- count of unique titles by title
SELECT count(title),title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY 1 DESC;

-- Deliverable 2: The Employees Eligible for the Mentorship Program(30 points)
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title

INTO mentor_retirees

FROM employees as e

INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)

INNER JOIN titles as t
ON (e.emp_no = t.emp_no)

WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')

ORDER BY e.emp_no 
;



-- Create tbl of employees with more than 1 title, this will give us the nominator to calculate rate of promotion
SELECT count(emp_no),emp_no
into promotion_count
from retirement_titles
group by emp_no
;

SELECT COUNT(emp_no)
from promotion_count
where count>1;

--new mentor pool, increase age range
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO new_mentor_retirees
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)

WHERE (e.birth_date BETWEEN '1960-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

select count(*) as count, title
from new_mentor_retirees
group by title
order by count desc;