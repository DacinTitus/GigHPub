-- Drop Tables

DROP TABLE IF EXISTS Restaurants;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS Jobs;
DROP TABLE IF EXISTS EmployeesJobs;


-- Create Tables

CREATE TABLE Restaurants (
restId int unique auto_increment not NULL,
restName varchar(255) not NULL,
city varchar(255) not NULL,
state varchar(255) not NULL,
PRIMARY KEY (restId)
);

create table Menu (
menuId int unique auto_increment not NULL,
restId int,
item varchar(255) not NULL,
price int not NULL,
primary key (menuId),
foreign key (restId)
references Restaurants(restId)
on delete set NULL
);

create table Employees (
empId int unique auto_increment not NULL,
restId int,
lastName varchar(255) not NULL,
firstName varchar(255) not NULL,
primary key (empId),
foreign key (restId)
references Restaurants(restId)
on delete set NULL
);

create table Jobs (
jobId int unique auto_increment not NULL,
title varchar(255) not NULL,
responsibilites TEXT,
primary key (jobId)
);

create table EmployeesJobs (
empId int not NULL,
jobId int not NULL,
primary key (empId, jobId),
foreign key (empId)
references Employees(empId)
on delete cascade,
foreign key (jobId)
references Jobs(jobId)
on delete cascade
);

-- Fill Tables

-- Restaurant

INSERT INTO Restaurants (restName, city, state) VALUES
("Nasty's Classy Pub", "Gig Harbor", "Washington");

-- Menu

insert into Menu (restId, item, price) values
(1, "Pizza", 15),
(1, "Nachos", 9),
(1, "Cherry Collins", 7);

-- Employees
insert into Employees (restId, lastName, firstName) values
(1, "Mom", "Mary"),
(1, "Pop", "Jackson"),
(1, "Tutu", "Dariano");

-- Jobs

insert into Jobs (title, responsibilites) values
("Bartender", "Pour drinks and be friendly"),
("Mascot", "Smile for the Pub's sign"),
("Manager", "Manage stuff");

-- EmployeesJobs

insert into EmployeesJobs (empId, jobId) values
(1, 3),
(2, 2),
(3, 1);
