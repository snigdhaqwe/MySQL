insert into emp(name) values
("Snigdha"),("Smriti"),("Shephalika"),("Ankita"),("Anurakta"),("Rimpy"),("Pratima");
select * from emp;
alter table emp add experience int;
update emp set experience = 8 where ID=1;
update emp set experience = 6 where ID=2;
update emp set experience = 9 where ID=3;
update emp set experience = 10 where ID=4;
update emp set experience = 6 where ID=5;
update emp set experience = 8 where ID=6;
update emp set experience = 7 where ID=7;

select distinct(name), experience from emp;
insert into emp(name, experience) values
("Ajay",10);
create table emp_1 like emp;
drop table emp_1;
select * from emp_1;
create table department(Dept_id int not null auto_increment,
Dept_name varchar(20) not null,
primary key(dept_id)
);
describe department;

create table department_foreign_child(
id int not null auto_increment,
emp_name varchar(20) not null,
experience int,
dept_id int, 
primary key(id),
foreign key(dept_id) references department(dept_id)
);
select * from department_foreign_child; -- id, emp_name, experience, dept_id(foreign/mul) -> child
select * from department; -- dept_id(pri), dept_name -> parent

describe department;

insert into department(dept_name) values
("HR"),
("Finance"),
("IT"),
("Operations")
;
insert into department_foreign_child(emp_name,experience,dept_id)
Values
("Arindam",14,3),
("Snigdha",8,3),
("Smriti",14,3),
("Rimpy",14,3),
("Shephalika",15,3),
("Ankita",15,2),
("Pratima",11,2);


