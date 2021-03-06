# Project 3

## project 3
- yay more separation of concerns with **microservices architecture**
	- Single Responsibility Principle for each microservice
	- has its own db and doesn't share with anyone else
	- exposes API
	- container orchestration to tell us how to arrange many containers and how to run 
		- most commpon is Kubernetes
		- but we're using Docker Swarm (not as popular)
			- docker.compose.yml (also outdated)
				- e.g. want x number of that container and hidden behind something
- has 3 microservices in the back end: user, room, batch [asp.net apis]
	- with selection and forecast module communicates with all three
	- have an ngUi containing (selection module and forecast module)
	- has "Angular library"
		- one or more modules to publish to npm and get included in app
		- uses "ng-package" format
- https://github.com/revaturexyz
- https://dev.azure.com/revaturexyz/housing
- https://sonarcloud.io/organizations/revaturexyz/projects
- https://cloud.docker.com/u/revaturexyz/repository/list
- https://www.pivotaltracker.com/dashboard
- development branch is called broker
	- within are user story branches
		- then there needs to be more branches for each tasks and needs review from team leads
- **teams**
	- Auth: *conrad*, lee, oswaldo, andy, daniel
		- auth with AzureAD
		- UI
		- forecast (currently does not properly connect to microservices)
	- Queues: *storm*, matt k, matt v, ben, will
		- setting up queues correctly 
		- Azure Service Bus
		- Selection Service
		- moarr logging (Serilog)
	- team leads set up user stories on *Pivotal* which needs Nick's approval
- Database
	- PostgreSQL with EF for selection and forecast
	- user, room, batch uses non relational db 
		- using MongoDB "document based" db
			- no schemas
	- currently no persistent db, we would need to implement it
- Prototype
	- set up prototypes to try understand how the things work

### Forecast Overview
- ui:
	- ForecastModule has 12 components
		- BarChartComponent
		- DoughnutChartComponent
		- DummyComponent
		- ForecastComponent
		- InputSelectorComponent
		- LineChartComponent
		- LocationBreakdownComponent
		- LocationsComponent
		- PieChartComponent
		- PolarAreaChartComponent
		- RadarChartComponent
		- SnapshotsComponent
	- find components within the projects folder
	- needs a ton of work in the forecast.service.ts since it's just using seeded data
- api:
	- Models:
		- Address
			- The Address class contains standard address information that will be used for Users, Batches, and Rooms
		- Batch
			- The Batch class contains standard batch info having name, occupancy, skill, and state
		- Name
			- The Name Class contains standard information regarding a User's name including first name, middle name, and last name.
		- Room
			- Room Class contains location, vacancy, occupancy, gender, address
		- Snapshot
			- The Snapshot class is used to represent the supply and demand of Rooms and Users on any given date
		- User
			- The User model is used to contain all of the pertinent information about a user including name, location, room, address, email, gender, employee type, and batch they belong to.
	- https://github.com/revaturexyz/housing-forecast/blob/broker/src/Housing.Forecast.Service/Controllers/ForecastController.cs
		- controllers is fun, those GET requests and then a whole bunch of repo logic under
	- Routes:
		- GET: api/forecast/Locations
		- GET: api/forecast/Snapshots
		- GET: api/forecast/Snapshots/createdDate
		- GET: api/forecast/Snapshots/start/end
		- GET: api/forecast/Snapshots/start/end/location
		- then they seemed to have 
	- They use Seeder within Program.cs with all of those fake data that gets generated each time we run
	- Usage of Poller.cs within the Housing.Forecast.Context 
		- used to update the database using the service endpoints.
		- used to update the database independently of the service allowing us to poll the service endpoints on a regular interval.

## Auth
- Search concepts like:  OAuth2.0 and OpenID Connect, v1.0, v2.0
- look at this for Angular: https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-angular/README.md

### [OpenID Connect](https://docs.microsoft.com/en-us/azure/active-directory/develop/v1-protocols-openid-connect-code)
- [extra reading](https://openid.net/connect/)
- identity layer built on top of the OAuth 2.0 protocol
	- OAuth 2.0 defines how to obtain and use access tokens to access protected resource
		- does not define standard methods to provide identity information
	- OpenID Connect implements auth as an extension
		- provides info about end user in form of `id_token` that verifies identity of user and gives basic profile info 

## Things to look into
- Security 