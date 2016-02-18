//
//  Ingredient.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/18/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import Foundation
import ObjectMapper


class Ingredient: Mappable {
    var uri: String?
    var quantity: Double?
    var unit: String?
    var name: String?
    
    required init?(_ map: Map){
        mapping(map)
    }
    
    func mapping(map: Map){
        uri <- map["uri"]
        quantity <- map["quantity"]
        unit <- map["measure.label"]
        name <- map["food.label"]
    }
}