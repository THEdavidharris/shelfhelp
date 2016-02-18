//
//  Recipe.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/18/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
//Not sure what the correct import should be

class Recipe: Mappable {
    
    var uri: String?
    var label: String?
    var imageURL: NSURL?
    var source: String?
    var sourceURL: String?
    var ingredientArray: [Ingredient]?
    
    required init?(_ map: Map){
        mapping(map)
    }
    
    func mapping(map: Map){
        uri <- map["uri"]
        label <- map["label"]
        imageURL <- map["image"]
        source <- map["source"]
        sourceURL <- map["source"]
        ingredientArray <- map["ingredients"]
    }
}
