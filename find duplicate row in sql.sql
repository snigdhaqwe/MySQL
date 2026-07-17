alter table employee add location int;
alter table employee modify location varchar(25);
desc employee; 
alter table employee drop column location; 
desc employee; 
create table EMP_1(ID INT primary key auto_increment, Name varchar(25));
desc emp_1;
insert into emp_1 values(1, "Arindam");
insert into emp_1 (Name) values ("Anshu");
select * from emp_1;
use sakila;
describe sakila;
describe actor;
select * from actor;
use da_june_2026;
select * from emp;
describe emp;
insert into emp(id,name,experience)
values(1,"Snigdha",8),
(2,"Pratima",10),
(3,"Smriti",11),
(3,"Smriti",11),
(4,"Rimpy",14);

select * from emp;
select * from  emp;

-- To find duplicate rows in a table
select ID,name,experience,count(*)
from emp
group by ID,name,experience
Having count(*)>1;


