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
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functionality
    
    func updateIngredientList(ingredients: Set<Ingredient>){
        
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
}
