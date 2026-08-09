select * from emp_salary;
select emp_name, count(*) as total_name from emp_salary
group by emp_name
having total_name <=1;

select dept_id,avg(salary) as average_salary from emp_salary
group by dept_id; -- How much is the average salary per department. 

