
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
    
    @IBOutlet weak var tableHeader: UIView!
    
    // MARK: Variables
    var recipe: Recipe!
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        self.ingredientTable.tableHeaderView = self.tableHeader
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // Hide the navbar and tabbar
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.hidesBottomBarWhenPushed = true

        
        self.recipeTitle.text = recipe.label
        recipeTitle.adjustsFontSizeToFitWidth = true
        self.recipeImage.kf_setImageWithURL(NSURL(string: recipe.imageURL)!)
        
        let realm = try! Realm()
        if realm.objectForPrimaryKey(Recipe.self, key: (self.recipe?.uuid)!) != nil{
            addMealButton.enabled = false
            addMealButton.tintColor = UIColor.clearColor()
        }
        
        goToRecipeButton.layer.cornerRadius = 10
        goToRecipeButton.layer.borderWidth = 1
        goToRecipeButton.layer.borderColor = UIColor.blueColor().CGColor
        goToRecipeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        
        if let recipeSource = self.recipe?.source{
            let sourceString = " View at \(recipeSource) "
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
        return recipe.staticIngredients.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "recipeIngredientCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecipeIngredientTableViewCell
        
        let ingredient = recipe?.staticIngredients[indexPath.row]
        
        cell.ingredientLabel.text = ingredient?.stringValue

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ingredients"
    }
    
    // MARK: Actions
    
    @IBAction func followLinkToRecipe(sender: UIButton) {
        let openLink = NSURL(string: String((recipe?.sourceURL)!))
        UIApplication.sharedApplication().openURL(openLink!)
    }
    
    @IBAction func addMealToList(sender: UIBarButtonItem) {
                
        // Get the default Realm
        let realm = try! Realm()
        
        // Add to the Realm inside a transaction
        try! realm.write {
            for item in self.recipe!.ingredientArray {
                item.recipeName = self.recipe!.label
                item.setCompoundKey()
            }
            realm.add(self.recipe!)
        }
        
        addMealButton.enabled = false
        addMealButton.tintColor = UIColor.clearColor()
        
        let alertController = UIAlertController(title: "Recipe added!", message: self.recipe!.label, preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
        let delay = 0.9 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        
    }
    
    // MARK: Helper Functions

}
