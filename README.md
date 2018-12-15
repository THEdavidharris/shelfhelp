# shelfhelp

The first iOS app I ever tried writing with a team in undergrad. Might be worth a blog post on common starting out mistakes :)

## todo
* Grocery List Screen
  * ~~Sort by meal and alphabetical by ingredient using the segment controller~~
  * Fix the gap between segment controller and table
  * Mark as bought and do more than just check it
  * ~~Delete all~~
    * Better location for the button maybe? 
  * Delete bought items
  * Add individual items
  * ~~Edit button that will slide all cells to allow for editing~~
    * Design for that 
  * Table animation on delete cell
  * Re-implement ingredient stacking
* Meal List Screen
  * Make it prettier (bigger cells and pictures)
  * Fix bug where clicking on meal doesn't set picture
* Recipe Search Screen
  * Make it prettier, same as meal list screen
  * Default text in the search box as a user cue
  * When new API added: when bottom of table is reached, fetch and add next 'page' of results (is easy with Food2Fork)
* Recipe Screen
  * Get rid of box behind text: just the text shadow works
  * ~~User feedback alert when recipe is added~~
    * Make prettier
  * Put the whole screen in a scroll view
  * Make prettier, the button is weird
  * Get rid of the box that says ingredients and make it a table section header
  * 
  
Helpful Links
http://stackoverflow.com/questions/29672666/swift-how-to-delete-with-edit-button-and-deactivate-swipe-to-delete
* API Transition to Food2Fork Changes
  * Change the Recipe Fetcher class to new URL and response
  * Change all the models so that they reflect the new JSON data structure
  * Use our Heroku app to parse ingredients when either meal is view or added (need to decide when)
    * Send URL to app, app responds with parsed JSON that can be used to build ingredient objects (already done)
* Design
  * ~~Add logo~~
    * One of them is wrong size, not sure how to fix 
  * Add launch screen
  * Make top bar design
  * Get mockups from Max that will help
* General
  * Method to retrieve images is deprecated, switch to Kingfisher Library to get images from URL
  * Use Realm Notifications handling to update data for screens before the willAppear() method might improve performance
  * Background threading of changing object properties in Realm?
* Bugs
  * ~~Deleting an ingredient deletes it from the meal screen too~~
  * ~~Recipe screen from saved recipes needs to retrieve the image from the right URL~~


