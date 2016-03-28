# shelfhelp

## todo
* Grocery List Screen
  * ~~Sort by meal and alphabetical by ingredient using the segment controller~~
  * ~~Fix the gap between segment controller and table~~
  * Mark as bought and do more than just check it
  * Delete all
  * Delete bought items
  * Add individual items
  * Edit button that will slide all cells to allow for editing
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
* Bugs
  * ~~Deleting an ingredient deletes it from the meal screen too~~
  * Recipe screen from saved recipes needs to retrieve the image from the right URL


