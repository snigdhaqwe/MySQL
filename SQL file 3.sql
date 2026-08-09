create table delete_example as select emp_name,experience,dept_id from department_foreign_child;
delete from delete_example where emp_name = "Snigdha" ;
select * from delete_example;
delete from delete_example where experience in(11,15) ;
select * from department_foreign_child;
select * from department_foreign_child order by experience ASC;
select * from department_foreign_child order by experience desc;
select * from department_foreign_child order by emp_name ASC;
select * from department_foreign_child order by emp_name desc;
select * from department_foreign_child order by emp_name ASC,experience desc limit 4;


create table emp_salary(
id int not null auto_increment,
salary int not null, 
emp_name varchar(30),
experience int,
dept_id int,
primary key(id)
);
describe emp_salary;
insert into emp_salary(salary,emp_name,experience,dept_id)
values
(1200,"Smriti",11,101),
(12003,"Rimpy",8,102),
(200000,"Snigdha",8,103),
(500000,"Pratima",1,104),
(120000000,"Ankita",15,105),
(60000000,"Shephalika",15,106);


select * from emp_salary;

select experience, count(*) as total_people from emp_salary
group by experience; 

-- find out how many people work in dept number 106? 
SELECT dept_id, COUNT(*) AS employee_count
FROM emp_salary
WHERE dept_id = 106;

select dept_id, count(*) from emp_salary group by dept_id;

insert into emp_salary values
(7,13000,"Ajit",11,106);




