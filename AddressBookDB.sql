--AddressBook System

--UC1 Start
--Ability to create a Address Book Service DB

create database AddressBookServiceDB;

use AddressBookServiceDB;

--UC1 End



--UC2 Start
--Ability to create a Address Book Table with first and last names, address, city, state, zip, phone number and email as its attributes

create table AddressBook_Table
(
id int primary key identity(1,1),
FirstName varchar(100),
LastName varchar(100),
Address varchar(100),
City varchar(100),
State varchar (100),
Zip bigint,
PhoneNumber bigint,
Email varchar(100)
);
select * from AddressBook_Table;

--UC2 End


--UC3 Start
--Ability to insert new Contacts to Address Book

insert into AddressBook_Table(FirstName, LastName, Address, City, State, Zip, PhoneNumber, Email)
values
('John', 'Elia', 'Bihar', 'Bihar', 'UP', 123456, 124567890, 'j@gmail.com'),
('Shreyas', 'Iyer', 'Bandra', 'Mumbai', 'Maharashtra', 456123, 7894561230, 'shreyas@gmail.com'),
('Shahrukh', 'Khan', 'Mannat', 'Mumbai', 'Maharashtra', 560037, 4567891230, 'srk@gmail.com'),
('Yuvraj', 'Singh', 'Ludhiyana', 'Ludhiyana', 'Punjab', 560103, 0456123895, 'yuvi@gmail.com');

select * from AddressBook_Table;

--UC3 End


--UC4 Start
--Ability to edit existing contact person using their name

update AddressBook_Table set City = 'Pune' where FirstName = 'John';
update AddressBook_Table set State = 'Delhi' where LastName = 'Singh';
select * from AddressBook_Table;

--UC4 End


--UC5 Start
--Ability to delete a person using person's name

delete from AddressBook_Table where FirstName = 'Shreyas';
select * from AddressBook_Table;

--UC5 End


--UC6 Start
--Ability to Retrieve Person belonging to a City or State from the Address Book 

select * from AddressBook_Table where City = 'Pune' or State = 'Maharashtra';

--UC6 End


--UC7 Start
--Ability to understand the size of address book by City and State 

select COUNT(*) as StateCount, State from AddressBook_Table group by State;
select COUNT(*) as CityCount, City  from AddressBook_Table group by City;

--UC7 End

--UC8 Start
--Ability to retrieve entries sorted alphabetically by Person’s name for a given city

select * from AddressBook_Table order by FirstName;

--UC8 End


--UC9 Start
--Ability to identify each Address Book with name and Type.

alter table AddressBook_Table add ContactType varchar(100);
update AddressBook_Table set ContactType='Family' where FirstName='John';
update AddressBook_Table set ContactType='Friends' where FirstName='Shahrukh' or FirstName='Yuvraj';

select * from AddressBook_Table;


--UC9 End


--UC10 Start
--Ability to get number of contact persons i.e. count by type

select COUNT(ContactType) as TypeCount, ContactType from AddressBook_Table group by ContactType;

--UC10 End



--UC11 Start
--Ability to add person to both Friend and Family

insert into AddressBook_Table(FirstName, LastName, Address, City, State, Zip, PhoneNumber, Email, ContactType)
values
('Charlie', 'Bond', 'Washington DC', 'Washington DC', 'America', 560040, 1231231235, 'charlie@gmail.com', 'Friend'),
('Charlie', 'Bond', 'Washington DC', 'Washington DC', 'America', 560040, 1231231235, 'charlie@gmail.com', 'Family');
select * from AddressBook_Table;

use AddressBookServiceDB;
drop table AddressBook_Table;

create table AddressBook_Table
(
id int primary key identity(1,1),
FirstName varchar(100),
LastName varchar(100),
Address varchar(100),
City varchar(100),
State varchar (100),
Zip bigint,
PhoneNumber bigint,
Email varchar(100)
);

create table Contact_Type_Table
(
typeId int primary key identity(1,1),
ContactType varchar(50),
id int FOREIGN KEY REFERENCES AddressBook_Table(id)
);

insert into AddressBook_Table(FirstName, LastName, Address, City, State, Zip, PhoneNumber, Email)
values
('John', 'Elia', 'Bihar', 'Bihar', 'UP', 123456, 124567890, 'j@gmail.com'),
('Shreyas', 'Iyer', 'Bandra', 'Mumbai', 'Maharashtra', 456123, 7894561230, 'shreyas@gmail.com'),
('Shahrukh', 'Khan', 'Mannat', 'Mumbai', 'Maharashtra', 560037, 4567891230, 'srk@gmail.com'),
('Yuvraj', 'Singh', 'Ludhiyana', 'Ludhiyana', 'Punjab', 560103, 0456123895, 'yuvi@gmail.com');

insert into AddressBook_Table(FirstName, LastName, Address, City, State, Zip, PhoneNumber, Email)
values
('Charlie', 'Bond', 'Washington DC', 'Washington DC', 'America', 560040, 1231231235, 'charlie@gmail.com'),
('Charlie', 'Bond', 'Washington DC', 'Washington DC', 'America', 560040, 1231231235, 'charlie@gmail.com');

select * from AddressBook_Table;

insert into Contact_Type_Table(ContactType,id)
values('Friends',1);

insert into Contact_Type_Table(ContactType,id)
values('Family',2);

insert into Contact_Type_Table(ContactType,id)
values('Office',3);

insert into Contact_Type_Table(ContactType,id)
values('Office',4);


insert into Contact_Type_Table(ContactType,id)
values('Family',5);

insert into Contact_Type_Table(ContactType,id)
values('Friends',6);

select * from Contact_Type_Table;

select FirstName,LastName,ContactType from AddressBook_Table inner join Contact_Type_Table on AddressBook_Table.id=Contact_Type_Table.id;

select * from AddressBook_Table inner join Contact_Type_Table on AddressBook_Table.id=Contact_Type_Table.id;

--UC11 End



--UC13 Start
--Ensure all retrieve queries done especially in UC 6, UC 7, UC 8 and UC 10 are working with new table structure

--UC6

select * from AddressBook_Table inner join Contact_Type_Table on AddressBook_Table.id=Contact_Type_Table.id where City = 'Mumbai' or State = 'Punjab';

--UC7

select COUNT(*) as StateCount, State from AddressBook_Table inner join Contact_Type_Table on AddressBook_Table.id=Contact_Type_Table.id group by State;
select COUNT(*) as CityCount, City  from AddressBook_Table inner join Contact_Type_Table on AddressBook_Table.id=Contact_Type_Table.id group by City;

--UC8

select AddressBook_Table.id,FirstName,LastName,Address,City,State,Zip,PhoneNumber,Email,ContactType from AddressBook_Table inner join Contact_Type_Table on AddressBook_Table.id=Contact_Type_Table.id order by FirstName;

--UC10
select COUNT(ContactType) as TypeCount, ContactType from AddressBook_Table inner join Contact_Type_Table on AddressBook_Table.id=Contact_Type_Table.id group by ContactType;

--UC13 End