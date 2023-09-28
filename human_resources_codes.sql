--Q 1 Find the longest ongoing project for each department --
select p.name as project_name ,d.name as department_name,
p.end_date-p.start_date  as  no_of_days_of_project from departments d
inner join projects p on d.id=p.department_id
order by no_of_days_of_project desc


--Q 2 Find all employees who are not managers--
SELECT *
FROM employees
WHERE id NOT IN (SELECT  manager_id FROM departments );

--Q3 Find all employees who have been hired after the start of a project in their department.--

SELECT e.*
FROM employees e
INNER JOIN projects p ON e.department_id = p.department_id
WHERE e.hire_date > p.start_date;

/*Q 4 Rank employees within each department based on their hire date 
(earliest hire gets the highest rank).*/
SELECT d.name AS department_name,e.name AS employee_name,e.hire_date,
 DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.hire_date) AS hire_date_rank
FROM employees e
JOIN departments d ON e.department_id = d.id
ORDER BY e.department_id, hire_date_rank;

/* Q 5 Find the duration between the hire date of each employee and
the hire date of the next employee hired in the same department.*/
select e.name,e.hire_date,d.name as department_name,
lead(hire_date) over(partition by department_id) as next_hiring_date,
lead(hire_date) over(partition by department_id)-e.hire_date as duration
	from employees e inner join 
departments d on e.department_id=d.id


