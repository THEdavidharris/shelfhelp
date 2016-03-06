//
//  RecipeViewController.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/22/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables
    var recipe: Recipe?
    var tbvc: RecipeTabBarController!
    
    // MARK: Attributes
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var ingredientTable: UITableView!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        
        
        // Connect to TabBarController
        self.tbvc = tabBarController as! RecipeTabBarController
        
        
        // Hide the navbar and tabbar
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.hidesBottomBarWhenPushed = true

        
        self.recipeTitle.text = recipe?.label
        self.recipeImage.image = recipe?.image
        self.recipeDescription.text = recipe?.summary
        if (self.recipeDescription.text==nil){
            //self.recipeDescription.text = "No description provided."
            self.recipeDescription.text = String((recipe?.sourceURL)!)
            // put button with source in it, click takes you to url
        }

        
        return
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        ingredientTable.rowHeight = UITableViewAutomaticDimension
        ingredientTable.estimatedRowHeight = 160.0
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.ingredientArray?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "recipeIngredientCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecipeIngredientTableViewCell
        let ingredient = recipe?.ingredientArray?[indexPath.row]
        
        cell.ingredientLabel.text = ingredient?.text
                                                //.name
        
        //if ((ingredient?.quantity)! != nil && (ingredient?.quantity)! > 0.0){
        if (false){
            cell.ingredientQuantityLabel.text = String(format: "%.3f", (ingredient?.quantity)!)
            cell.ingredientUnitLabel.text = ingredient?.unit
        } else {
            cell.ingredientQuantityLabel.text = ""
            cell.ingredientUnitLabel.text = ""
        }
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func saveMealAndIngredients(savedRecipe: Recipe){
        tbvc.savedRecipes.append(savedRecipe)
        
        tbvc.updateIngredientList(savedRecipe.ingredientArray!)
        
    }

}
