//
//  SecondViewController.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 2/17/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit
import RealmSwift

class MealListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Attributes
    
    @IBOutlet weak var mealTable: UITableView!
    var tbvc: RecipeTabBarController!
    
    // MARK: Variables
    
    var mealList = [Recipe]()
    
    var recipeList: Results<Recipe>!
    
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        mealList = self.tbvc.savedRecipes
        mealTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mealTable.delegate = self
        mealTable.dataSource = self
        
        self.tbvc = tabBarController as! RecipeTabBarController
        
        mealList = self.tbvc.savedRecipes
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Realm data handling
    func readRecipesAndUpdateUI(){
        let realm = try! Realm()
        recipeList = realm.objects(Recipe)
        self.mealTable.reloadData()
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mealListToRecipeViewSegue" {
            if let destination = segue.destinationViewController as? RecipeViewController {
                if let tableIndex = mealTable.indexPathForSelectedRow?.row {
                    destination.recipe = mealList[tableIndex]
                }
            }
        }
    }
    
    // MARK: UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        mealTable.rowHeight = UITableViewAutomaticDimension
        mealTable.estimatedRowHeight = 160.0
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mealList.count)
        // took out self.tbvc.savedRecipes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = mealList[indexPath.row]
        
        cell.mealLabel.text = meal.label
        cell.photoImageView.image = meal.image
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            self.tbvc.savedRecipes.removeAtIndex(indexPath.row)
            mealList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        }
    }
}

