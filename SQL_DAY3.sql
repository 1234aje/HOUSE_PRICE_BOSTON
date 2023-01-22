use db_test;
-- insert data
-- insert into table_name (column_names) values(),();
-- the no of columns equals to the no of values provided
-- select * from table; z
-- where clause : select,update,delete
-- delete:  delete with where, can be used to delete specific records
-- truncate : where cant be added, deletes entire data
-- drop : drops table from db , drop column
-- update : used to modify the actual data
-- update table_name set column_name= new value where condition;
-- alter  : used to modify the table structure
-- add column,modify column, rename column, drop column
-- order by : used to sort the data. dafult is ascending , desc keyword 
-- select * from table_name order by column1,column2;
-- distinct : used to get the unique values from a table
-- select distinct column_name from table_name;
-- aggregate functions :
-- sum,avg,min,max,count
-- count(*): gives the no of records/no of rows
-- count(1):gives the no of records/no of rows
-- count(column_name) : calculates the count of non null values 

-- limit : 
-- limit(offset,no of rows to read)
-- offset : no of rows to skip
-- no of rows to read
-- default value of offset is 0
select * from emp_data limit 5;
select * from emp_data limit 4,6;

-- fetch records from 10 to 20
select * from emp_data limit 9,11;

-- fetch rows from 40  to 45
select * from emp_data limit 39,6;

-- 6th record from a table
select * from emp_data limit 5,1;

-- nth record from a table
-- select * from emp_data limit n-1,1;

-- group by 
select distinct loc from emp_data;
-- count of emp for each loc
select count(empid) from emp_data where loc='dallas';
select count(empid) from emp_data where loc='chicago';
select count(empid) from emp_data where loc='new york';

-- 100 rows : dallas(30), chicago(30), new york (40)
/*
loc       count_of_emp
dallas    30
chicago   30
new yor   40
*/

select count(empid) from emp_data;
select loc,count(empid) from emp_data group by loc;
-- 100 rows : dallas(30): F or M, chicago(30) : F or M, new york (40): F or M
select loc,gender,count(empid) from emp_data group by loc; -- will not work

-- 100 rows : dallas(30): F(15) or M(15), chicago(30) : F(15) or M(15), new york (40): F(20) or M(20)
select loc,gender,count(empid) from emp_data group by loc,gender;

select loc,gender,count(empid) from emp_data group by loc,gender order by loc;

-- display sum of salaries, count of emp where salary <50000 for each dept
select dept_id,sum(salary),count(empid) from emp_data where salary <50000 group by dept_id;

-- having : filter out the groups 
-- to have only groups where count of emp <3
select dept_id,sum(salary),count(empid) from emp_data where salary <50000 group by dept_id
having count(empid)<3 order by dept_id desc limit 1;

-- select , from ,where , group by , having , order by , limit 

-- subqueries : query within query
-- select: outer select/outer query (select :inner select/inner query  == subquery
-- create (select

-- max salary from a table
select max(salary) from emp_data;

-- display the details of an emp having this max salary
select * from emp_data where salary=197537;
select * from emp_data where salary=(select max(salary) from emp_data); 

-- to fetch the second highest salary
select * from emp where salary <(select max(salary) from emp);
select * from emp;
/*
70000 -- exclude
50000
50000
40000
40000
*/
select max(salary) from emp where salary <(select max(salary) from emp);

-- limit 
-- 3rd highest salary
select distinct salary from emp order by salary desc limit 2,1;
select * from emp;

-- nth highest salary
-- select distinct salary from table_name order by salary desc limit n-1,1;

-- details of an emp having third highest salary
SELECT * from emp where salary =
(select distinct salary from emp order by salary desc limit 2,1);

-- views: 
-- used for data visualization
-- always created on top of any database table
-- cant perform DML(insert,update,delete) on view
-- data from views gets refreshed along with the table refresh

create view emp_view as select fname,salary,loc from emp;
select * from emp_view;
select * from emp;

insert into emp values(1005,'gaurav',80000,'mumbai');
update emp set loc='chennai' where loc is null;
delete from emp where fname='rohit';

select * from emp_data;
select max(salary) from emp_data;
select dept_id,max(salary) from emp_data group by dept_id;
/*
dept_id.       max(salary)
10.             184896
10.             184896
20.             190139
20				190139
30				197537
30				197537
*/

select dept_id,max(salary) over () as max_sal  from emp_data;

select dept_id,max(salary) over (partition by dept_id order by dept_id desc) as max_sal  from emp_data;

-- row_number() : assign an index value to each row
select empid, salary, row_number() over () as rn from emp_data;

select dept_id,empid, salary, row_number() over (partition by dept_id order by salary desc)
 as rn from emp_data;
 
 -- max 2 salaries from each partition
 
 select * from (
 select dept_id,empid, salary, row_number() over (partition by dept_id order by salary desc)
 as rn from emp_data
 ) SQ
 where rn <3;
 
 
 -- get the even no of rows 
 select * from (
 select dept_id,empid, salary, row_number() over ()
 as rn from emp_data
 ) SQ
 where rn%2=0;
 
 -- odd no of rows
 select * from (
 select dept_id,empid, salary, row_number() over ()
 as rn from emp_data
 ) SQ
 where rn%2!=0;
 
 












  

























