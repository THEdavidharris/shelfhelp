//
//  RecipeSearchViewController.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 2/17/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeSearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recipeTable: UITableView!
    
    // MARK: Variables
    
    var recipeResponse: RecipeResponseObject!
    var fetchedRecipes = [Recipe]()
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        recipeTable.delegate = self
        recipeTable.dataSource = self
        recipeTable.tableFooterView = UIView(frame: CGRect.zero)
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 24)!, NSForegroundColorAttributeName: UIColor.whiteColor()]

        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "searchToRecipeViewSegue" {
            if let destination = segue.destinationViewController as? RecipeViewController {
                if let tableIndex = recipeTable.indexPathForSelectedRow?.row {
                    destination.recipe = fetchedRecipes[tableIndex]
                }
            }
        }
    }
    
    
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

    
    // MARK: API Query Handling
    
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
        
    
    // MARK: UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(fetchedRecipes.count == 0){
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, recipeTable.bounds.size.width, recipeTable.bounds.size.height))
            noDataLabel.text = "Use the search bar to find recipes"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.Center
            recipeTable.backgroundView = noDataLabel
            return 0            
        }
        else{
            recipeTable.backgroundView = nil
            return 1
        }
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
        cell.recipeSource.text = recipe.source
        
        cell.recipeImage.kf_setImageWithURL(NSURL(string: recipe.imageURL)!)
        
        
        cell.recipeImage.layer.shadowOffset = CGSizeMake(0, 0)
        cell.recipeImage.layer.shadowColor = UIColor.blackColor().CGColor
        cell.recipeImage.layer.shadowRadius = 4
        cell.recipeImage.layer.shadowOpacity = 0.25
        cell.recipeImage.layer.masksToBounds = false;
        cell.recipeImage.clipsToBounds = true;
        return cell
        
    }
    
}
