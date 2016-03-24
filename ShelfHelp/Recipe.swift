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
    
    var ingredientSet: Set<Ingredient> = Set()
    
    // Non-stored properties
    dynamic var image: UIImage?
    
    required convenience init?(_ map: Map){
        self.init()
    }
    
    override static func ignoredProperties() -> [String] {
        return ["image", "ingredientSet"]
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
        ingredientSet <- map["ingredients"]
        
        for item in ingredientSet {
            ingredientArray.append(item)
        }
        
        return
    }
}
