//
//  RecipeSearchViewController.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 2/17/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {

    // MARK: Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recipeTable: UITableView!
    
    // MARK: Variables
    var recipeResponse: RecipeResponseObject?
    var fetchedRecipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        recipeTable.delegate = self
        //recipeTable.dataSource = self
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
        if let queryText = searchBar.text {
            self.makeCall(queryText)
        }
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
            }
            else{
                // Do something to handle the error
            }
        }
    }

}
