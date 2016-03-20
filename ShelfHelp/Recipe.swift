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
    dynamic var imageURL = NSURL(string: "")
    dynamic var source = ""
    dynamic var sourceURL = NSURL(string: "")
    let ingredientArray = List<Ingredient>()
    
    // Non-stored properties
    dynamic var image: UIImage?
    
    required convenience init?(_ map: Map){
        self.init()
    }
    
    override static func ignoredProperties() -> [String] {
        return ["image"]
    }
    
    override static func primaryKey() -> String {
        return "uuid"
    }
    
    func mapping(map: Map){
        uri <- map["uri"]
        label <- map["label"]
        imageURL <- (map["image"], URLTransform())
        source <- map["source"]
        sourceURL <- (map["url"], URLTransform())
        
        var ingredientSet: Set<Ingredient>?
        ingredientSet <- map["ingredients"]
        
        for item in ingredientSet! {
            ingredientArray.append(item)
        }
        
        return
    }
}
