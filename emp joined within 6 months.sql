select * from departments; -- department_id,department_name,location
select * from employees; -- employee_id,first_name,last_name,department_id,salary,hire_date,manager_id
select * from managers; -- manager_id,manager_name, manager_salary
-- 5. Find employees who joined in the last 6 months. 
SELECT * FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);