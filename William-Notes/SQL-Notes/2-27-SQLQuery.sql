-- Join
--		Cross Join (join as cartesian product) every row in table 1 is combined with every row in table 2
--			result table size equals rows multiplied columns added
select e1.*, e2.*
from Employee as e1 cross join Employee as e2
--		inner join
--			most common kind of join
--			most common conditon for inner join foreign key = primary key
--			joining on 'true' is the same as cross join
select *
from Track inner join Genre on Track.GenreId = Genre.GenreId
--		outer join
--			left join
--				preserve left table fill null for empty right or drop for empty left
--			right join
--				preserve right table fill null for empty left or drop for empty right
--			full join
--				preserve both tables fill null for empty data
select t.Name, g.Name
from Track t right join Genre g on t.GenreId = g.GenreId
-- can use varables, don't need AS to cast

-- all rock songs in the database, showing artist name and song name
select ar.name + '-' + t.name
from track t
	inner join Album al on t.AlbumId = al.AlbumId
	inner join Artist ar on al.ArtistId = ar.ArtistId
	inner join Genre g on t.GenreId = g.GenreId
where g.name = 'Rock'

-- every employee together with who he reports to (his manager) if any
select emp.FirstName + ' ' + emp.LastName Employee,
	   mgr.FirstName + ' ' + mgr.LastName Manager
from Employee emp
	left outer join Employee mgr on emp.ReportsTo = mgr.EmployeeId

-- subqueries

-- another way (actually several ways) besides joins
-- to combine info from multiple tables

-- every track that has never been purchased
select *
from Track t
where t.TrackId not in (
	select TrackId
	from InvoiceLine
)
-- here we have a subquery in the WHERE clause of another query
-- we have operators IN, NOT IN

select t.Name
from Track t
where t.TrackId in (
	select top(3)TrackId
	from InvoiceLine
	group by TrackId
	order by count(*) desc
)
-- we have TOP(n) to take just the first n results of a query
-- the inner query is: get the top trackid, when we group all the invoicelines
-- by trackid and count up how many in each group

-- we can also have subqueries in HAVING (no difference)
-- but also in FROM clause

-- 
select *
from Track inner join(
	select Artist.Name Artist, Album.Title Album, Album.AlbumId AlbumId
	from Artist join Album on Album.ArtistId = Artist.ArtistId
	) as subq on Track.AlbumId = subq.AlbumId
where Track.Name < 'b'
-- similar to subquery in FROM is "common table expression" (CTE)
-- which uses a "WITH" clause

-- every track that has never been purchased (CTE version)
with purchased_tracks as (
	select distinct TrackId
	from InvoiceLine
	)
select *
from Track t
where t.TrackId not in (
	select TrackId
	from purchased_tracks
	)
-- some other subquery operators
-- EXISTS, NOT EXISTS
-- SOME, ANY, ALL

-- get the artist who made the album with the longest title
select *
from Artist
where ArtistId = (
	select ArtistId
	from Album
	where len(Title) >= all (select len(Title) from Album)
)

select *
from Artist
where ArtistId = (
	select top(1) ArtistId
	from Album
	order by len(Title) desc
)

-- set operations
-- we have from mathermatical set the concepts of 
-- UNION, INTERSECT, and (set difference) EXCEPT

-- all first names of customers and employees
select FirstName from Customer
union
select FirstName from Employee -- 63 results
-- all rows of the first query, and also all rows of the second query
-- (the number and types of columns need to be compatible)

-- for each set op, we have a DISTINCT version, and an ALL version.
-- the DISTINCT version is the default.
--	so by default, all these operators make a pass to remove duplicate rows from the result.
select FirstName from Customer
union all
select FirstName from Employee -- 67 results (has duplicates)

-- UNION gives you values that are in EITHER result
-- INTERSECT gives you values that are in BOTH results
-- EXCEPT gives you values that are in the FIRST but NOT the SECOND result.

-- SQL has many statements/commands
-- they are categorized as a number of "sub-languages"

-- Data Manipulation Language (DML) operates on individual rows.
-- there are five DML commands in SQL Server -

-- SELECT, INSERT, UPDATE, DELETE, TRUNCATE TABLE

-- SELECT is for read access to the rows

select * from Genre
-- insert
insert into Genre Values (26,'Misc')
-- really we should name the columns.
-- this is more readable / less error-prone
-- and it lets us skip columns that have default values we are OK with
insert into Genre (GenreId, Name) values (27, 'Misc 2')
insert into Genre (GenreId, Name) values (
	(select max(GenreId) from Genre) + 1,
	'Misc 3'
)

-- can insert multiple rows at once
insert into Genre (GenreId, Name) values
(29,'Misc 4'),
(30,'Misc 5')

insert into Genre (GenreId, Name)
	(select GenreId + 100, Name
	from Genre)

-- UPDATE
update Genre
set Name = 'Misc 1'
where Name = 'Misc'
	-- if we left out the where we would change every row
	-- could change more than one column comma separated
update Genre
set GenreId = GenreId - 50, Name = 'Miscellaneous' + substring(Name, 6,1)
where GenreId > 100 and Name like 'Misc%'

-- DELETE
delete from Genre
where GenreId > 100 -- without WHERE, would delete every row

-- TRUNCATE TABLE
-- truncate table Genre
-- deletes every row, no conditions

-- DELETE FROM Genre deletes every row, one at a time
--TRUNCATE TABLE Genre deletes every row all at once, faster

-- DDL

-- Data Definition Language
-- DDL operates on whole tables at a time, can't see individual rows.
-- DDL also works with lots of other DB objects, like views, functions, procedures
-- triggers, constraints, etc.

-- to create, change, and delete these DB objects, we have:
-- CREATE, ALTER, DROP

-- go is special keyword to separate batches of commands
-- some commands demand to be in their own batch
go
create schema Movie
go
-- CREATE TABLE:
-- create table gets comma-separated list of columns
-- each column 
create table Movie.Movie (
	MovieId int
)

select * from Movie.Movie

-- we have ALTER TABLE to add or delete columns
--  (and do some other things too)
alter table Movie.Movie ADD
	Title nvarchar(200)

-- delete an entire table
drop table Movie.Movie

-- we can specify constraints on each column

-- constraints:
--	NOT NULL
--	NULL (not really a constraint, just being explicit)
--		(default behavior null is allowed)
--	PRIMARY KEY (set PK, enforces uniqueness, sets clustered index)
--		(implies not null, but we like to be explicit anyway)
--	UNIQUE (can be set on multiple columns taken together)
--	CHECK (an arbitrary condition that must be true for each row)
--	DEFAULT (give a default value for that column when inserted without explicit value)
--		null is default default
--	FOREIGN KEY
--	IDENTITY(start, increment) (not exactly a constraint, but similar)
--		identity(10,10) would count: 10, 20...
--		default values are 1,1. (counting: 1,2,3,4,5)
--		by default , we aren't allowed to give explicit values for IDENTITY columns

drop table Movie.Movie
create table Movie.Movie (
	MovieId int not null primary key identity(1,1),
	Title nvarchar(200) not null,
	ReleaseDate datetime2 not null,
	DateModified datetime2 not null default(getdate())
	constraint U_Movie_Title_Date unique (Title, ReleaseDate),
	-- CONSTRAINT PK_blah PRIMARY KEY (col1, col2) -- composite pk
	constraint CHK_DateNotTooEarly check (ReleaseDate > '1900')
)

insert into Movie.Movie (Title, ReleaseDate) values (
	'LOTR: The Fellowship of the Ring', '2001'
)

select * from Movie.Movie

create table Movie.Genre (
	GenreId int not null primary key identity(1,1),
	Name nvarchar(100) not null,
	DateModified datetime2 default(getdate()),
	check (Name != '')
)

alter table Movie.Movie add
	GenreId int null,
	constraint FK_Movie_Genre foreign key (GenreId) references Movie.Genre (GenreId)

drop table Movie.Genre
-- adding columns without some default (or allowing null as default) is not allowed
-- workaround allow null at first, fix up existing rows, then add NOT NULL constraint

insert into Movie.Genre (Name) Values ('Action/Adventure')
update Movie.Movie set GenreId = 1;

delete from Movie.Genre

alter table Movie.Movie add constraint NN_GenreID not null (GenreId)