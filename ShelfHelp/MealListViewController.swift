//
//  SecondViewController.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 2/17/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class MealListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mealTable: UITableView!
    var tbvc: RecipeTabBarController!
    var mealList = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mealTable.delegate = self
        mealTable.dataSource = self
        
        self.tbvc = tabBarController as! RecipeTabBarController
        
        mealList = self.tbvc.savedRecipes
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        mealTable.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mealListToRecipeViewSegue" {
            if let destination = segue.destinationViewController as? RecipeViewController {
                if let tableIndex = mealTable.indexPathForSelectedRow?.row {
                    destination.recipe = mealList[tableIndex]
                }
            }
        }
    }
    
    // MARK: Table View Functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tbvc.savedRecipes.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = mealList[indexPath.row]
        
        cell.mealLabel.text = meal.label
        cell.photoImageView.image = meal.image
        
        return cell
    }


}

