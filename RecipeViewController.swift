//
//  RecipeViewController.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/22/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    // MARK: Variables
    var recipe: Recipe?
    
    // MARK: Attributes
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.hidden = false
        
        self.recipeTitle.text = recipe?.label
        self.recipeImage.image = recipe?.image
        self.recipeDescription.text = recipe?.summary
        return
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
