//
//  Ingredient.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/18/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import Foundation
import ObjectMapper



class Ingredient: Mappable, Hashable {
    var text: String?
    var quantity: Double?
    var unit: String?
    var name: String?
    
    var hashValue: Int {
        return self.text!.hashValue
    }
    
    required init?(_ map: Map){
        mapping(map)
    }
    
    func mapping(map: Map){
        text <- map["text"]
        quantity <- map["quantity"]
        unit <- map["measure.label"]
        name <- map["food.label"]
    }

}

func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
    return lhs.text == rhs.text
}