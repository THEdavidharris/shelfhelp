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
    var from: Int?
    var to: Int?
    var moreResultsAvailable: Bool?
    var totalCount: Int?
    var hits: [Recipe]?
    
    required init?(_ map: Map){
        mapping(map)
    }
    
    func mapping(map: Map){
        query <- map["q"]
        from <- map["from"]
        to <- map["to"]
        moreResultsAvailable <- map["more"]
        totalCount <- map["count"]
        hits <- map["hits"]
        
    }
    
    
}
