//
//  RecipeSearchViewController.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 2/17/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class RecipeSearchViewController: UIViewController, UISearchBarDelegate {

    // MARK: Properties
    @IBOutlet weak var RecipeSearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecipeSearch.delegate = self
        // Do any additional setup after loading the view.
        
        //Make the API call here
        let apiFetcher = RecipeFetcher()
        apiFetcher.getRecipes(){ (responseObject, error) in
            print("responseObject = \(responseObject); error = \(error)")
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        RecipeSearch.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
