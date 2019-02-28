select * from dbo.Customer
select * from dbo.Employee
select * from dbo.Invoice
select * from dbo.InvoiceLine
-- international customers
select CustomerId, FirstName, LastName, Country from dbo.Customer where Country <> 'USA'
-- brazilian customers
select CustomerId, FirstName, LastName, Country from dbo.Customer where Country = 'Brazil'
-- sales agents
select EmployeeId, FirstName, LastName from dbo.Employee where Title = 'Sales Support Agent'
-- list of countries on billing invoice
select distinct BillingCountry from dbo.Invoice
-- sales in 2009 and total
select count(invoiceDate), sum(Total) from dbo.Invoice where datepart(year, InvoiceDate) = '2009'
--													   where InvoiceDate between '2009' AND '2010'
-- every year
select year(InvoiceDate) as year, count(InvoiceDate) as Count, sum(Total) as Total from dbo.Invoice group by year(InvoiceDate)
-- line items in invoice #37
select Count(Quantity) as Count from dbo.InvoiceLine where InvoiceId = 37
-- invoices per country
select count(InvoiceId), BillingCountry from dbo.Invoice group by BillingCountry
-- sales total by country ordered by highest first
select BillingCountry, sum(Total) as Total from dbo.Invoice group by BillingCountry  order by Total desc

