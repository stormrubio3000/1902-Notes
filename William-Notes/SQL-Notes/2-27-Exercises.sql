select * from dbo.Customer
select * from dbo.Employee
select * from dbo.Invoice
select * from dbo.InvoiceLine
select * from Playlist
select * from PlaylistTrack
select * from Artist
select * from Album
select * from Track
select * from Genre
select * from MediaType
--1: show all customers mailing address brazil
select count(I.InvoiceId) Invoices, c.Country from Invoice I join Customer c on I.CustomerId = c.CustomerId where c.Country = 'Brazil'
--2: show all invoices together with sales agent
select count(I.InvoiceId) Invoices, e.FirstName + ' ' + e.LastName as Employee from Invoice I join Customer c on I.CustomerId = c.CustomerId join Employee e on e.EmployeeId = c.SupportRepId group by e.FirstName, e.LastName
--3: show all playlists ordered by total number of tracks they have
select count(pt.PlaylistId) Tracks, p.Name from Playlist p join PlaylistTrack pt on p.PlaylistId = pt.PlaylistId group by p.Name order by Tracks
--4: which sales agent made the most sales in 2009
--5: how many customers are assigned to each sales agent
--6: which track was purchased the most since 2010
--7: show the top 3 best selling artists
--8: which customers have the same initials as at least 1 other customer

-- subquery and union exercises
--1: which artists did not make any album at all
--	subquery
select * from Artist a where a.ArtistId not in ( select ArtistId from Album)
--	join

--2: which artists did not record any tracks in the latin genre
select * from Artist a where a.ArtistId not in ( select ArtistId from Album al where al.AlbumId in (select AlbumId from Track t where t.GenreId = (select GenreId from Genre g where g.Name = 'Latin')))
--3: which video track has the longest length (use media type table)
select top(1)* from Track t where t.MediaTypeId = (select MediaTypeId from MediaType m where m.Name = '%video%')
--4: find the names of the customers that live in the same city as the boss employee (the one that reports to no one)
--5: how many audio tracks were bought by German customers and what was the total price paid for them
--6: list the names and countries of the customers supported by an employee who was hired younger than 35

-- rest of DML exercises
--1: insert 2 new records into Employee table
insert into Employee (EmployeeId, Lastname, FirstName) values 
	((select max(EmployeeId) from Employee) + 1, 'Craig', 'William'),
	((select max(EmployeeId) from Employee) + 2, 'Rubio', 'Storm')

--2: insert 2 new records into the Track table
insert into Track ( TrackId, Name, UnitPrice, MediaTypeId, Milliseconds) values
	(3504,'bumble bee', 0.01, (select MediaTypeId from MediaType m where m.Name  like 'MPEG%'), 1000 ),
	(3505,'dumble dee', 0.01, (select MediaTypeId from MediaType m where m.Name  like 'MPEG%'), 1000 )
--3: update customer Aaron Mitchell's name to Robert Walter
update Customer
set  FirstName = 'Robert', LastName = 'Walter'
where FirstName = 'Aaron' and LastName = 'Mitchell'

--4: delete one of the Employees you inserted
delete from Employee
where LastName = 'Rubio'
--5: delete customer Robert Walter 
delete from InvoiceLine
where InvoiceId in (select InvoiceId from Invoice i where i.CustomerId = (select CustomerId from Customer c where c.FirstName = 'Robert' and LastName = 'Walter'))
delete from Invoice
where CustomerId = (select CustomerId from Customer c where c.FirstName = 'Robert' and LastName = 'Walter')
delete from Customer
where FirstName = 'Robert' and LastName = 'Walter'
