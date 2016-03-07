//
//  GroceryTableViewCell.swift
//  ShelfHelp
//
//  Created by Humza Siddiqui on 2/17/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class GroceryTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
