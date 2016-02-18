//
//  RecipeFetcher.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/18/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class RecipeFetcher {
    
    var query: String?
    
    static let api_url = "https://api.edamam.com/search"
    
    let params = [
        "app_id": "2a0606b2",
        "app_key": "1b56a25e79ac65f480899138abdfcfcd",
        "q": "chicken",
        "from": "20"
    ]
    
    
    
    class func getRecipes(){
        //implement
        //Alamofire.request(.GET, api_url, parameters: params).lots of other stuff has to happen
    }
    
    
}


