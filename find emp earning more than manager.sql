select * from departments; -- department_id,department_name,location
select * from employees; -- employee_id,first_name,last_name,department_id,salary,hire_date,manager_id
select * from managers; -- manager_id,manager_name, manager_salary

alter table managers add column manager_salary int;
update managers set manager_salary = 50000 where manager_id=201;
update managers set manager_salary = 60000 where manager_id=202;
update managers set manager_salary = 70000 where manager_id=203;

-- 3. Retrieve employees who earn more than their manager.
select employees.first_name,employees.salary as employee_salary,managers.manager_name,managers.manager_salary 
from employees
Join managers
where 
employees.salary>managers.manager_salary ;
