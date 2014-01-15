Ruby-Automotive
===============
I love working on my own cars. I wish there were an app out there to help me track the cost of my DIY projects and the information on parts I've researched/purchased.

Requirements
------------
* Simple Feature Set
* CRUD
* Contains at least one complex query
* No live API calls, data stored in repository

Features
--------
- List Cars
- To tal repair cost per vehicle
- Repair project history
- Parts and warranty information
- Average annual cost of repairs
- Average hours per project
- Scheduled Maintenance: Oil Changes, Brake Pads, Belts, Tires, Plugs, Battery, Shocks, etc.

External Data
-------------
- Edmunds API for car value based on mileage and age
- Semantics3 API for parts information and pricing

DB Structure
------------
Tables
- Cars
- Projects
- Parts
- Warranties
- MaintenanceTasks

Join Tables
- Cars_Projects
- Projects_Parts
- Parts_Warrenties
- Cars_MaintenanceTasks
