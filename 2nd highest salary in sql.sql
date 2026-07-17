select * from emp;
alter table emp
add column salary int;
insert into emp(salary)
values(1000),
(2000),
(3000),
(4000);
alter table emp
add column salary int;

alter table emp
drop column salary;
UPDATE emp SET salary = 1000 WHERE name = "Snigdha";
UPDATE emp SET salary = 2000 WHERE name = "Pratima";
UPDATE emp SET salary = 3000 WHERE name = "Smriti";
UPDATE emp SET salary = 4000 WHERE name = "Rimpy";
SELECT @@SQL_SAFE_UPDATES;
SET SQL_SAFE_UPDATES = 0;
select max(salary) as SecondHighestSalary
from emp
where(salary)<(select max(salary) from emp);

