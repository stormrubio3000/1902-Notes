# project 1: store web app
February 18 2018 Arlington .NET / Nick Escalona

## functionality
* place orders to store locations for customers
* get a suggested order for a customer based on his order history
* search customers by name
* display details of an order
* display all order history of a store location
* display all order history of a customer
* display order history sorted by earliest, latest, cheapest, most expensive
* display some statistics based on order history
* persistent data (SQL)
* client-side validation
* server-side validation
* exception handling
* CSRF prevention
* logging

## structure

### business logic
* class library
* contains all business logic
* contains entity classes (customer, order, store, product, etc.)
* has no dependency on UI or any input/output considerations
* repository pattern (whether implemented here or in the data access project) abstracts EF-based data access

### user interface
* ASP.NET MVC web application
* strongly-typed views
* minimize logic in views
* customize the default styling to some extent

### data access
* class library
* contains EF DbContext
* if it has DTOs, no business logic should be on them

### test
* use TDD for some of the application
* focus on unit testing business logic
* data access tests should not impact the app's actual database

## object model
### customer
* has first name, last name, etc.
* has a default store location to order from
* cannot place more than one order from the same location within two hours

### order
* has a store location
* has a customer
* has an order time (when the order was placed)
* multiple types of products can be ordered at once
* must have some additional business rules

### location
* has an inventory
* inventory decreases when orders are accepted
* rejects orders that cannot be fulfilled with remaining inventory
* relationship between products sold and inventory required must have some complexity for at least one product
* has order history

### products

## technologies
* C#/.NET
* ASP.NET MVC
* Entity Framework
* Azure SQL DB
* xUnit, NUnit, or MSTest
* Serilog or NLog
