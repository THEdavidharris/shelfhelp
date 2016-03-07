//
//  FirstViewController.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 2/17/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Attributes
    @IBOutlet weak var groceryTable: UITableView!
    // MARK: Variables
    var tbvc: RecipeTabBarController!
    var groceryList=[Ingredient]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        groceryTable.delegate = self
        groceryTable.dataSource = self
        self.tbvc = tabBarController as! RecipeTabBarController
        
        groceryList = self.tbvc.groceryList
        
        print("Loading grocery list:")
        for thingy in groceryList{
            print(thingy.name)
        }
        
        groceryTable.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("Reloading grocery list")
        groceryList = self.tbvc.groceryList
        groceryTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tbvc.groceryList.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GroceryItemCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroceryTableViewCell
        let ingredient = groceryList[indexPath.row]
        
        cell.ingredientLabel.text = ingredient.name        
        return cell
    }



}

