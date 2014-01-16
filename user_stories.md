<pre>
  Use Case #1
  As a vehicle owner that has entered information about their car into the application
  I want to get the current value of my vehicle based on its mileage

  Usage: ./autotracker value "2006 Jetta"

  Acceptance Criteria:
  * Prints out price paid for the car, as well as current value
  * If the car can't be found, prints cars with similar name
</pre>

<pre>
  Use Case #2
  As a vehicle owner that has entered information about a repair project into the application
  I want to get the details of the project, including parts and completion time

  Usage: ./autotracker project "Wiring Harness"

  Acceptance Criteria:
  * Prints out list of parts involved with their cost
  * Prints description of project, date, mileage, special notes, and completion time
  * If the project can't be found, prints projects with similar name
</pre>

<pre>
  Use Case #3
  As a vehicle owner that has entered information about a part into the application
  I want to get the cost of the part, the date purchased, and the project in which it was used

  Usage: ./autotracker part "Brake Rotor"

  Acceptance Criteria:
  * Prints out description of part including cost, project, and date purchased
  * If the part can't be found, prints parts with similar name
</pre>