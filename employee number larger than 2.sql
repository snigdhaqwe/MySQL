select * from departments; -- department_id,department_name,location
select * from employees; -- employee_id,first_name,last_name,department_id,salary,hire_date,manager_id
select * from managers; -- manager_id,manager_name, manager_salary

-- 4. Count employees in each department having more than 2 employees. 
SELECT departments.department_id,
       departments.department_name,
       COUNT(employees.employee_id) AS employee_count
FROM departments
JOIN employees
    ON departments.department_id = employees.department_id
GROUP BY departments.department_id, departments.department_name
HAVING COUNT(employees.employee_id) > 2;
