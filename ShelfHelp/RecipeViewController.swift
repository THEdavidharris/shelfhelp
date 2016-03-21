//
//  RecipeViewController.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/22/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit
import RealmSwift

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Attributes
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet weak var addMealButton: UIBarButtonItem!
    @IBOutlet weak var goToRecipeButton: UIButton!
    
    // MARK: Variables
    var recipe: Recipe?
    var prevIngredient: String = ""
    
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        
        
        // Hide the navbar and tabbar
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.hidesBottomBarWhenPushed = true

        
        self.recipeTitle.text = recipe?.label
        self.recipeImage.image = recipe?.image
        
        
        if let recipeSource = self.recipe?.source{
            let sourceString = "View recipe at \(recipeSource)"
            
            self.goToRecipeButton.setTitle(sourceString, forState: .Normal)
        }
        
        
        
        return

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        ingredientTable.rowHeight = UITableViewAutomaticDimension
        ingredientTable.estimatedRowHeight = 160.0
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.ingredientArray.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "recipeIngredientCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecipeIngredientTableViewCell
        
        let ingredient = recipe?.ingredientArray[indexPath.row]
        
        cell.ingredientLabel.text = ingredient!.text

        return cell
    }
    
    // MARK: Helper Functions
    
    func saveMealAndIngredients(savedRecipe: Recipe){
        
        //tbvc.updateIngredientList(savedRecipe.ingredientArray)
        
//        func updateIngredientList(ingredients: [Ingredient]){
//            
//            print("Updating ingredient list")
//            
//            // For each ingredient:
//            var found: Bool = false
//            
//            
//            for newItem in ingredients {
//                for item in groceryList {
//                    // If it exists in the list
//                    if item.name == newItem.name {
//                        found = true
//                        // Check that units are the same
//                        if item.unit == newItem.unit {
//                            // Update value
//                            item.quantity += newItem.quantity
//                        }
//                            // If units are different
//                        else {
//                            groceryList.append(newItem)
//                        }
//                        break
//                    }
//                    
//                }
//                
//                // Not found
//                if (!found){
//                    groceryList.append(newItem)
//                }
//                found = false;
//            }
//            
//        }
        
    }
    
    // MARK: Actions
    
    @IBAction func followLinkToRecipe(sender: UIButton) {
        let openLink = NSURL(string: String((recipe?.sourceURL)!))
        UIApplication.sharedApplication().openURL(openLink!)
    }
    
    @IBAction func addMealToList(sender: UIBarButtonItem) {
        
        self.saveMealAndIngredients(self.recipe!)
        
        // Get the default Realm
        let realm = try! Realm()
        
        // Add to the Realm inside a transaction
        try! realm.write {
            realm.add(self.recipe!)
        }
    }

}
