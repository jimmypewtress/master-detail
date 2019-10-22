# MasterDetail

This is a simple iOS app that demostrates making an API call to a server, retrieveing a list of items and displaying them in a master/detail configuration.

The code is written completely by myself (Jimmy Pewtress) using Swift to the following brief:

*Imagine are working with HR department on an application that will help them list potential candidates for a particular role. Each participant is taking some number of practical programming challenges and HR personnel wants to keep a scoreboard of who scored the most points.*

*The goal is to create a simple app that will show a list of the candidate names and their scores in a UITableView. Once a row from the table is selected the app will segue into a view controller that will show user more details about the candidate.*

*You can request the newest data through: ​https://pastebin.com/raw/56tv0pgs*

***The basic application will:***
- *Be able to download the list of candidates from the URL above. Feel free to use AlamoFire or URLSession.*
- *Show all of the candidates sorted by their total score in a table view.*
- *Each cell of the table view should contain the name of the candidate and his points.*

***An enhanced application can (optional):***
- *Refresh the data using pull to refresh UIRefreshControl*
- *Show the total count of candidate in a UITableView header.*
- *Use custom cells to include an email address of the candidates in the cell.*

### Implementation
##### Architecture
This app uses a straightforward MVC architecture do to its simplicity, however for more complex projects I have also used [Clean Swift](https://clean-swift.com "Clean Swift").

Everything is done using standard iOS components rather than relying on any third party libraries and dependency managers.

The datasource for table/collection views is kept seperate from the view controller for ease of refactor and testibility.

##### Navigation
I have used a simple Coordinator pattern here as I favour view controllers not directly doing routing related tasks such as pushing other controllers on to navigation stacks. Having them independent makes it easier to change the position in flows etc

##### UI
In this particular instance I have manually coded the user interface, although I am equally happy using Interface Builder.
