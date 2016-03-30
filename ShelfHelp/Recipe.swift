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
import RealmSwift

class Recipe: Object, Mappable {
    
    // Stored properties
    dynamic var uuid = NSUUID().UUIDString
    dynamic var uri = ""
    dynamic var label = ""
    dynamic var imageURL = ""
    dynamic var source = ""
    dynamic var sourceURL = ""
    let ingredientArray = List<Ingredient>()
    
    // DO NOT DELETE ITEMS FROM THIS
    let staticIngredients = List<RLMString>()
    
    required convenience init?(_ map: Map){
        self.init()
    }
    
    override static func primaryKey() -> String {
        return "uuid"
    }
    
    func mapping(map: Map){
        uri <- map["uri"]
        label <- map["label"]
        imageURL <- map["image"]
        source <- map["source"]
        sourceURL <- map["url"]
        
        var ingredientSet: Set<Ingredient> = Set()
        ingredientSet <- map["ingredients"]
        
        for item in ingredientSet {
            ingredientArray.append(item)
            let obj = RLMString()
            obj.stringValue = item.text
            staticIngredients.append(obj)
        }
        
        return
    }
}
