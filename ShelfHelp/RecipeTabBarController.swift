//
//  TabBarController.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/23/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class RecipeTabBarController: UITabBarController {
    
    // MARK: Variables
    var savedRecipes = [Recipe]()
    var groceryList = [Ingredient]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("View did load - from TabBarController")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functionality
    
    func updateIngredientList(ingredients: [Ingredient]){
        
        print("Updating ingredient list")
        
        // For each ingredient:
        var found: Bool = false
        
        
        for newItem in ingredients {
            for item in groceryList {
                // If it exists in the list
                if item.name == newItem.name {
                    found = true
                    // Check that units are the same
                    if item.unit == newItem.unit {
                        // Update value
                        item.quantity! += newItem.quantity!
                    }
                    // If units are different
                    else {
                        groceryList.append(newItem)
                    }
                    break
                }
                
            }
            
            // Not found
            if (!found){
                groceryList.append(newItem)
            }
            found = false;
        }
        
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
