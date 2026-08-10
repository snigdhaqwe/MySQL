-- 6. Get departments with no employees. 
select * from departments; -- department_id,department_name,location
select * from employees; -- employee_id,first_name,last_name,department_id,salary,hire_date,manager_id
select * from managers; -- manager_id,manager_name, manager_salary

SELECT d.department_name 
FROM departments d 
LEFT JOIN employees e ON d.department_id = 
e.department_id 
WHERE e.department_id IS NULL; 