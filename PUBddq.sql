-- Data Definition Queries for Pub Management System

-- table structure for menu

DROP TABLE IF EXISTS Menu;
create table Menu (
menuId int unique auto_increment not NULL,
restId int,
item varchar(255) not NULL,
price int not NULL,
primary key (menuId)
);

-- dump data for menu

insert into Menu (restId, item, price) values
(1, "Pizza", 15),
(1, "Nachos", 9),
(1, "Cherry Collins", 7);

-- table structure for employees

DROP TABLE IF EXISTS Employees;
create table Employees (
empId int unique auto_increment not NULL,
restId int,
lastName varchar(255) not NULL,
firstName varchar(255) not NULL,
primary key (empId)
);

-- dump data for employees

insert into Employees (restId, lastName, firstName) values
(1, "Mom", "Mary"),
(1, "Pop", "Jackson"),
(1, "Tutu", "Dariano");

-- table structure for jobs

DROP TABLE IF EXISTS Jobs;
create table Jobs (
jobId int unique auto_increment not NULL,
title varchar(255) not NULL,
responsibilites TEXT,
primary key (jobId)
);

-- dump data for jobs

insert into Jobs (title, responsibilites) values
("Bartender", "Pour drinks and be friendly"),
("Mascot", "Smile"),
("Manager", "Manage stuff");

-- table structure for EmployeesJobs

DROP TABLE IF EXISTS EmployeesJobs;
create table EmployeesJobs (
empId int not NULL,
jobId int not NULL,
primary key (empId, jobId)
);

-- dump data for EmployeesJobs

insert into EmployeesJobs (empId, jobId) values
(1, 3),
(2, 2),
(3, 1);

-- table structure for restaurants

drop table if exists restaurants;
CREATE TABLE Restaurants (
restId int unique auto_increment not NULL,
restName varchar(255) not NULL,
city varchar(255) not NULL,
state varchar(255) not NULL,
primary key (restId)
);

-- dump data for restaurants

INSERT INTO Restaurants (restName, city, state) VALUES
("Nasty's Classy Pub", "Gig Harbor", "Washington");

-- add foreign key constraints

alter table menu
add constraint fkMenu1
foreign key restaurants(restId)
references restaurants(restId)
on delete cascade;


alter table employees
add constraint fkEmp1
foreign key restaurants(restId)
references restaurants(restId)
on delete cascade;

alter table employeesjobs
add constraint fkEmpJob1
foreign key employees(empId)
references employees(empId)
on delete cascade,
add constraint fkEmpJob2
foreign key jobs(jobId)
references jobs(jobId)
on delete cascade;