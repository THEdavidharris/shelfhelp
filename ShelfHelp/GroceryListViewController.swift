//
//  FirstViewController.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 2/17/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit
import RealmSwift

class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Attributes
    
    @IBOutlet weak var groceryTable: UITableView!
    
    // MARK: Variables
    
    var ingredientList: Results<Ingredient>!
    var mealList: Results<Recipe>!
    
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        //retrieveIngredientsAndUpdateUI()
        retrieveMealsAndUpdateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        groceryTable.delegate = self
        groceryTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Realm data handling
    func retrieveIngredientsAndUpdateUI(){        
        let realm = try! Realm()
        ingredientList = realm.objects(Ingredient)
        self.groceryTable.reloadData()
    }
    
    func retrieveMealsAndUpdateUI(){
        let realm = try! Realm()
        mealList = realm.objects(Recipe)
        self.groceryTable.reloadData()
    }
    
    func deleteAllIngredientsAndUpdateUI(){
        let realm = try! Realm()
        try! realm.write {
            for item in ingredientList {
                realm.delete(item)
            }
        }
        self.groceryTable.reloadData()
    }
    
    // MARK: UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.mealList.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.mealList[section].label
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealList[section].ingredientArray.count
        // took out self.tbvc.groceryList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GroceryItemCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroceryTableViewCell
        
        let ingredient = self.mealList[indexPath.section].ingredientArray[indexPath.row]
        
        
        // What is this? --David
        cell.ingredientLabel.text = ingredient.name
        if (ingredient.unit != "" && ingredient.quantity > 0){
            cell.quantityLabel.text = String(format: "%.1f", ingredient.quantity)
            cell.unitLabel.text = ingredient.unit
        } else {
            cell.quantityLabel.text = ""
            cell.unitLabel.text = ""
        }
        
        if (ingredient.checked == true) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            let ingredientVictim = ingredientList[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(ingredientVictim)
            }
            
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.retrieveIngredientsAndUpdateUI()
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let tappedItem = ingredientList[indexPath.row] as Ingredient
        let realm = try! Realm()
        try! realm.write {
            tappedItem.checked = !tappedItem.checked
        }
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
    }

}

