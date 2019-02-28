-- in SSMS, like in VS, we have Ctrl+K,U for comment and uncomment

-- data types
--	numeric
--		integer
--			TINYINT		(1 byte) (like byte/char)
--			SMALLINT	(2 byte) (like short)
--			INT			(4 byte)
--			BIGINT		(8 byte) (like long)
--		floating point 
--			FLOAT
--			REAL
--			DECIMAL/NUMERIC(n,p) (highest-precision + custom precision -- we use this one)
--			decimal(4,3) means, r digits, with 3 of them after the decimal point.
--		currency
--			MONEY
--		string
--			CHAR/CHARACTER(n) fixed length character array with size N
--				uses one-byte-per-character encoding specified by the collation
--			VARCHAR/CHARACTER VARYING(n) variable length string up to size n
--				uses one-byte-per-character encoding specified by the collation
--				we can set n to MAX (VARCHAR(MAX)) and that will allow maximum size
--			NCHAR(n) unicode char (the N stands for 'national')
--			NVARCHAR(n) unicode varchar - this is the one we use all the time for string stuff.
--				we use this to store many international alphabets without depending on collation
--					when we say N'abc', this is an NVARCHAR
--		date/time
--			DATE for dates
--			TIME for times
--			DATETIME for timestamps, for times of a certain day
--				low precision and limited range! don't use
--			DATETIME2(n) for high-precision, wide-range timestamps.
--				n controls precision
--			DATETIMEOFFSET for intervals
--		we can use EXTRACT to get e.g. the YEAR from out of a DATETIME2.
--		there's also implicit conversions from strings, so i can compare
--		dates with '2019'

-- SELECT statement advanced usage
-- GROUP BY clause
-- by itself, it doesn't do a lot, but it becumes useful with aggregate functions
--	aggregate functions are functions that take in many values and return one value.
--		COUNT, AVG, SUM, MIN, MAX.

-- all first names of customers, and the number of duplicates of them.
select FirstName, count(FirstName) from SalesLT.Customer group by FirstName order by count(FirstName) desc;

-- GROUP BY accepts a list of columns, and all rows which share the same
-- values of all those columns are combined into one row in the result set.

-- if we have a GROUP BY, we can't use any column in the select list
-- unless we say how to combine it together.
-- EITHER, you make it the basis for combining rows (put it in the GROUP BY)
-- OR, you run some aggregate function which says how to turn the many values
-- into one value.

-- how can i show all first names haveing no duplicates?
select FirstName from SalesLT.Customer where count (FirstName) = 1 group by FirstName;
-- first rows from the table are filtered with WHERE,
-- THEN, we run any aggregations with GROUP BY.
-- if we want to run conditoins based on the aggregated rows, we need the HAVING clause.
select FirstName from SalesLT.Customer where LastName < 'n' group by FirstName having count(FirstName) = 1;

-- logical order of execution of a SELECT statement
-- essentially it "runs" in the order you write it, except, the SELECT clause is last.
-- 1. from
-- 2. where
-- 3. group by
-- 4. having
-- 5. select
-- 6. order by
