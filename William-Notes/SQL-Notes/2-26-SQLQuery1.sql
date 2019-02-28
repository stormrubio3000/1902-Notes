SELECT 'HELLO WORLD!';
SELECT * FROM AdventureWorksLT.SalesLT.Customer;
--Commenting in SQL with --

-- in a SQL server you have many databases.
-- within each database, we have many "schemas"
-- a schema is a namespace/scope for database objects

-- in AdventureWorksLT database, we have schema SalesLT
-- inside schemas, we ahve many db ogjects, incl. tables

-- this would switch databases (from master)
-- but Azure SQL DB doesn't support it yet.
USE AdventureWorksLT;
-- have to use dropdown instead.
-- whitespace doesn't matter
-- semicolons aren't necessary
-- SQL syntax is case insensitive

-- SQL's string comparison by default is also case-insensitive
-- but really that depends on the "collation" i.e. the
-- settings for datetime format, number format
select 1;
select CURRENT_TIMESTAMP;

-- we get all columns and all rows from a table with
-- select *, and from.
select *
from SalesLT.Customer;

-- we can select exactly which columns we want by replacing the *
select Title, FirstName, MiddleName, LastName
from SalesLT.Customer;

-- we can do "aliases" with as
-- the standard SQL way to spell an identifier with spaces is ""
-- the SQL Server way is []
select FirstName as [First Name], LastName as "Last Name"
from SalesLT.Customer;

-- we can process the returned rows with DISTINCT
-- any rows of the result set that have all the same column values
-- will be de-duplicated

-- get all first names that customers have.
select distinct FirstName
from SalesLT.Customer;

-- we can filter rows on conditions as well.
-- with WHERE clause.
select *
from SalesLT.Customer
where FirstName = 'Alice';
-- so we have boolean operators AND and OR and NOT, and
-- not equals != (or... traditional SQL <>)

-- we have ordered comparison of numbers, dates, times, and strings
-- strings are ordered by "dictionary order" "lexicographic order"
-- but this is affected by collation.
-- with operators < <= > >=
select *
from SalesLT.Customer
where FirstName >= 'c' AND FirstName < 'd';
-- everything that starts with c and has more letters too
-- sorts aftre 'c'

-- we can sort the results (they are in undefined order by default)
-- ORDER BY clause accomplishes this.
select * from SalesLT.Customer where FirstName >= 'c' AND FirstName < 'd' order by FirstName, LastName;
-- ordering is ascending (ASC) by default, but can be descending (DESC)

-- we can do regex-lite pattern matching on strings with LIKE operator.

-- all customers with firstname starting with c, then a vowel.
select * from SalesLT.Customer where FirstName like 'C[aeiou]%'
-- [abc] for one character, either a, b, or c
-- % for any number of any characters
-- _ for one of any character