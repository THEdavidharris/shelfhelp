//
//  Ingredient.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/18/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Ingredient: Object, Mappable, Hashable {
    dynamic var uuid = NSUUID().UUIDString
    dynamic var text = ""
    dynamic var quantity = 0.0
    dynamic var unit = ""
    dynamic var name = ""
    dynamic var checked = false
    dynamic var compoundKey = ""
    
    dynamic var nameAndUnitString = ""
    
    dynamic var recipeName = ""
    
    func setCompoundKey(){
        self.compoundKey = self.recipeName + self.name
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    required convenience init?(_ map: Map){
        self.init()
    }   
    
    func mapping(map: Map){
        text <- map["text"]
        quantity <- map["quantity"]
        unit <- map["measure.label"]
        name <- map["food.label"]
        
        nameAndUnitString = name + unit
    }

}

func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
    return lhs.text == rhs.text
}