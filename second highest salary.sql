select * from emp_salary;
-- 1. Find the second highest salary from the Employee table with who is earning it. 
select distinct(max(salary)) as second_highest_salary from emp_salary
where salary < (select max(salary) from emp_salary) ;

select emp_name, salary from emp_salary where salary = ( 
select max(salary) from emp_salary where salary < (select max(salary) from emp_salary)
) ;

SELECT emp_name, salary FROM emp_salary WHERE salary = (
SELECT MAX(salary) FROM emp_salary WHERE salary < (
SELECT MAX(salary) FROM emp_salary
    )
);