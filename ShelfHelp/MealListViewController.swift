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
    @IBOutlet weak var deleteAllMealsButton: UIBarButtonItem!
    
    // MARK: Variables
    var recipeList: Results<Recipe>!
    
    @IBOutlet weak var editMealListButton: UIBarButtonItem!
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        readRecipesAndUpdateUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        deleteAllMealsButton.tintColor = UIColor.clearColor()
        deleteAllMealsButton.enabled = false
        mealTable.delegate = self
        mealTable.dataSource = self
        
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
    
    func deleteAllRecipesAndUpdateUI(){
        let realm = try! Realm()
        try! realm.write {
            for item in recipeList{
                realm.delete(item)
            }
        }
        self.mealTable.reloadData()
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mealListToRecipeViewSegue" {
            if let destination = segue.destinationViewController as? RecipeViewController {
                if let tableIndex = mealTable.indexPathForSelectedRow?.row {
                    destination.recipe = recipeList[tableIndex]
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
        return (recipeList.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = recipeList[indexPath.row]
        
        cell.photoImageView.kf_setImageWithURL(NSURL(string: meal.imageURL)!)
        cell.mealLabel.text = meal.label
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            let recipeVictim = recipeList[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(recipeVictim)
            }
            
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.readRecipesAndUpdateUI()
            
        }
    }
    
    // MARK: Actions
    
    @IBAction func editMealList(sender: UIBarButtonItem) {
        print("Edit meal pushed")
        self.mealTable.editing = !self.mealTable.editing
        if (editMealListButton.title == "Edit"){
            editMealListButton.title = "Cancel"
            deleteAllMealsButton.tintColor = UIColor.redColor()
            deleteAllMealsButton.enabled = true
        } else {
            editMealListButton.title = "Edit"
            deleteAllMealsButton.tintColor = UIColor.clearColor()
            deleteAllMealsButton.enabled = false
        }
    }
    @IBAction func deleteAllMeals(sender: UIBarButtonItem) {
        
        // put in confirmation here!
        
        
        
        let confirmAlert = UIAlertController(title: "Delete all", message: "Are you sure you want to delete this list? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popToRootViewControllerAnimated(true)
            self.deleteAllRecipesAndUpdateUI()
            self.editMealListButton.title = "Edit"
            self.deleteAllMealsButton.tintColor = UIColor.clearColor()
            self.deleteAllMealsButton.enabled = false
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            confirmAlert .dismissViewControllerAnimated(true, completion: nil)
            print ("CANCELED MEAL DELETE")
            
            
        }))
        
        presentViewController(confirmAlert, animated: true, completion: nil)
        


    }
    
    
}

