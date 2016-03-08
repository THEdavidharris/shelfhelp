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
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        recipeTable.delegate = self
        recipeTable.dataSource = self

        self.navigationController?.navigationBar.hidden = true
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
    
    func requestImage(url: NSURL, success: (UIImage?) -> Void){
        requestURL(url, success: { (data) -> Void in
            if let d = data {
                success(UIImage(data: d))
            }
        })
    }
    
    func requestURL(url: NSURL, success: (NSData?) -> Void, error: ((NSError) -> Void)? = nil){
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: url), queue: NSOperationQueue.mainQueue(), completionHandler: { response, data, err in
            if let e = err{
                error?(e)
            } else {
                success(data)
            }
        })
    }
    
    
    // MARK: UITableViewDelegate
    
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
        
        requestImage(recipe.imageURL!) { (image) -> Void in
            let myImage = image
            recipe.image = myImage
            cell.recipeImage.image = myImage
        }
        
        return cell
    }
    
}
