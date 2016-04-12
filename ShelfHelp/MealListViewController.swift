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
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 24)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
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
        if(recipeList.count == 0){
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, mealTable.bounds.size.width, mealTable.bounds.size.height))
            noDataLabel.text = "No saved recipes"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.Center
            mealTable.backgroundView = noDataLabel
            return 0            
        }
        else{
            mealTable.backgroundView = nil
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipeList.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = recipeList[indexPath.row]
        
        //cell.photoImageView.kf_setImageWithURL(NSURL(string: meal.imageURL)!)
        cell.mealLabel.text = meal.label
        
//        cell.photoImageView.layer.shadowOffset = CGSizeMake(0, 0)
//        cell.photoImageView.layer.shadowColor = UIColor.blackColor().CGColor
//        cell.photoImageView.layer.shadowRadius = 4
//        cell.photoImageView.layer.shadowOpacity = 0.25
//        cell.photoImageView.layer.masksToBounds = false;
//        cell.photoImageView.clipsToBounds = true;
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            let recipeVictim = recipeList[indexPath.row] as Recipe
            let realm = try! Realm()
            
            for item in recipeVictim.ingredientArray {
                try! realm.write {
                    realm.delete(item)
                }
            }
            
            for anotherOne in recipeVictim.staticIngredients {
                try! realm.write {
                    realm.delete(anotherOne)
                }
            }
            
            try! realm.write {
                realm.delete(recipeVictim)
            }
            
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            mealTable.reloadData()
            
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
            self.mealTable.reloadData()
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            confirmAlert .dismissViewControllerAnimated(true, completion: nil)
            print ("CANCELED MEAL DELETE")
            
            
        }))
        
        presentViewController(confirmAlert, animated: true, completion: nil)
        


    }
    
    
}

