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
    
    static let api_url = "https://api.edamam.com/search"
    
    class func getRecipes(query: String, completionHandler: (RecipeResponseObject?, NSError?) -> ()){
        makeCall(query, completionHandler: completionHandler)
    }
    
    
    class func makeCall(query: String, completionHandler: (RecipeResponseObject?, NSError?) -> ()){
        
        let params = [
            "app_id": "2a0606b2",
            "app_key": "1b56a25e79ac65f480899138abdfcfcd",
            "from": "20",
            "q": query
        ]
        
        
        Alamofire.request(.GET, api_url, parameters: params).validate().responseObject {
            (response: Response<RecipeResponseObject, NSError>) in
            switch response.result {
            case .Success(let value):
                print("API GET success")
                completionHandler(value, nil)
            case .Failure(let error):
                print("API GET FAILURE")
                completionHandler(nil, error)
            }
            
        }
    }
    
    
}


