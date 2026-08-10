-- 2. Find duplicate records in a table. 
select * from emp_salary;
select emp_name, count(*) from emp_salary
group by emp_name
having count(*) > 1 ;
