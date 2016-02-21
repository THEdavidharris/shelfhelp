//
//  RecipeResponseObject.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/18/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper


class RecipeResponseObject: Mappable {
    
    var query: String?
    var from: Int!
    var to: Int!
    var moreResultsAvailable: Bool?
    var totalCount: Int?
    var tempRecipe: Recipe!
    
    var countRetrieved: Int!
    var recipeArray: [Recipe]!
    
    required init?(_ map: Map){
        //mapping(map)
    }
    
    func mapping(map: Map){
        query <- map["q"]
        from <- map["from"]
        to <- map["to"]
        moreResultsAvailable <- map["more"]
        totalCount <- map["count"]
        
        self.countRetrieved = self.to - self.from
        self.recipeArray = [Recipe]()
        for index in 0...self.countRetrieved-1{
            tempRecipe <- map["hits.\(index).recipe"]
            recipeArray.append(tempRecipe)
        }
        
        
        
        
    }
    
    
}
