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
    
    // MARK: Variables
    var recipeList: Results<Recipe>!
    
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        readRecipesAndUpdateUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        requestImage(NSURL(string: meal.imageURL)!) { (image) -> Void in
            let myImage = image
            meal.image = myImage
            cell.photoImageView.image = myImage
        }
        
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
    
    // MARK: Image Request Handling
    
    func requestImage(url: NSURL, success: (UIImage?) -> Void){
        requestURL(url, success: { (data) -> Void in
            if let d = data {
                success(UIImage(data: d))
            }
        })
    }
    
    func requestURL(url: NSURL, success: (NSData?) -> Void, error: ((NSError) -> Void)? = nil){
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: url), queue: NSOperationQueue.mainQueue(), completionHandler: { response, data, err in
            if let e = err{
                error?(e)
            } else {
                success(data)
            }
        })
    }
}

