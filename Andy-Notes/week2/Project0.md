# project 0: store application
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
* search customers by name
* save all data to disk in XML or JSON format
* load all data from disk
* input validation
* exception handling
* logging

## structure

### business logic
* class library
* contains all business logic
* contains entity classes (customer, order, store, product, etc.)
* has no dependency on UI or any input/output considerations

### user interface
* interactive console application
* has only display- and input-related code
* low-priority component, will be replaced when we move to project 1

### test
* use TDD for some of the application
* focus on unit testing business logic; testing the console app is very low priority

## object model
### customer
* has first name, last name, etc.
* has a default store location to order from
* cannot place more than one order from the same location within two hours

### order
* has a store location
* has a customer
* has an order time (when the order was placed)
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
* xUnit, NUnit, or MSTest
* Serilog or NLog
