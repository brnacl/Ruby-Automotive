User Stories
============

<h4>As a vehicle owner I want to enter a new car into the database</h4>
<pre>
  Usage: ./autotracker new_car

  Acceptance Criteria:
  * Asks user for car Make
  * Asks user for car Model
  * Asks user for car Year
  * Asks user for car Trim Package
  * Asks user for car Condition
  * Asks user for car Purchase Date
  * Asks user for car Mileage
  * Asks user for car ZipCode
  * If the car can't be found in the API, asks user to resubmit with Different trim Package
  * Once car value is successfully retreived, displays the information from database for new Car object
</pre>

<h4>As a vehicle owner that has entered information about their car into the application I want to enter a DIY repair project for that vehicle</h4>
<pre>
  Usage: ./autotracker new_project

  Acceptance Criteria:
  * Displays list of cars with their DB ID's
  * Asks user for car ID
  * Asks user for project Name
  * Asks user for project Description
  * Asks user to add part (y/n)
  * If yes, asks user for part Name, Description, and Price
  * Continues prompting user to add part until response is No
  * Asks user for current car Mileage
  * Once all data is entered, displays the information from database for new Project object and associated Parts objects
</pre>

<h4>As a vehicle owner that has entered information about a Project into the application I want to add a part to that project</h4>
<pre>
  Usage: ./autotracker new_part

  Acceptance Criteria:
  * Displays list of cars with their DB ID's
  * Asks user for car ID
  * Displays Projects for that car with DB ID's
  * Asks user for Project ID
  * Asks user for part Name, Description, and Price
  * Once all data is entered, displays the information from database for Project object and associated Parts objects
</pre>

<h4>As a vehicle owner that has entered information about their car into the application I want to get the current value of my vehicle based on its mileage</h4>
<pre>
  Usage: ./autotracker car_value

  Acceptance Criteria:
  * Displays list of cars with their DB ID's
  * Asks user for Car ID
  * Asks user for current car mileage
  * Updates DB with current mileage and current value, based on Edmunds API response
</pre>

<h4>As a vehicle owner that has entered information about a repair project into the application I want to get the details of the project, including parts and completion time</h4>
<pre>
  Usage: ./autotracker show_project

  Acceptance Criteria:
  * Displays list of cars with their DB ID's
  * Asks user for Car ID
  * Displays Projects for that car with DB ID's
  * Asks user for Project ID
  * Displays the information from database for Project object
</pre>

<h4>As a vehicle owner that has entered information about a project into the application I want to display a list of the parts used in that project and their total cost</h4>
<pre>
  Usage: ./autotracker show_parts

  Acceptance Criteria:
  * Displays list of cars with their DB ID's
  * Asks user for Car ID
  * Displays Projects for that car with DB ID's
  * Asks user for Project ID
  * Displays data for all associated Parts and a Grand Total value from the Project object
</pre>

