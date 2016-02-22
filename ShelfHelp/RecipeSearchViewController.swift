//
//  RecipeSearchViewController.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 2/17/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recipeTable: UITableView!
    
    // MARK: Variables
    var recipeResponse: RecipeResponseObject!
    var fetchedRecipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        recipeTable.delegate = self
        recipeTable.dataSource = self
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.fetchedRecipes.removeAll()
        if let queryText = searchBar.text {
            self.makeCall(queryText)
        }
        return
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    
    // MARK: API query handling
    func makeCall(query: String){
        //Make the API call here
        let apiFetcher = RecipeFetcher()
        apiFetcher.getRecipes(query){ (responseObject, error) in
            print("responseObject = \(responseObject); error = \(error)")
            if error == nil {
                self.recipeResponse = responseObject
                self.fetchedRecipes = self.recipeResponse.recipeArray
            }
            else{
                // Do something to handle the error
            }
            
            self.recipeTable.reloadData()
            return
        }
    }
    
    // MARK: Table View Handling
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedRecipes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "FetchedRecipeTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FetchedRecipeViewCellTableViewCell
        
        // Fetches the appropriate recipe
        let recipe = fetchedRecipes[indexPath.row]
        
        cell.recipeName.text = recipe.label
        // TODO: more for image and stuff
        
        return cell
        
        
        
        
    }
    

}
