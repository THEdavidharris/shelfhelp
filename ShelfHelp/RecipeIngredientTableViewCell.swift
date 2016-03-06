//
//  RecipeIngredientTableViewCell.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 3/6/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class RecipeIngredientTableViewCell: UITableViewCell {

    // MARK: Attributes
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var ingredientQuantityLabel: UILabel!
    @IBOutlet weak var ingredientUnitLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
