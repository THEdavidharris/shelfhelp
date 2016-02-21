//
//  FetchedRecipeViewCellTableViewCell.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/21/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import UIKit

class FetchedRecipeViewCellTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
