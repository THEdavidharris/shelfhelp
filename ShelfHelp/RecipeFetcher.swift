//
//  RecipeFetcher.swift
//  ShelfHelp
//
//  Created by Harris, David on 2/18/16.
//  Copyright © 2016 Humza Siddiqui. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class RecipeFetcher {
    
    let api_url = "https://api.edamam.com/search"
    
    func getRecipes(query: String, completionHandler: (RecipeResponseObject?, ErrorType?) -> Void){
        
        let params = [
            "app_id": "2a0606b2",
            "app_key": "1b56a25e79ac65f480899138abdfcfcd",
            "from": "0",
            "q": query
        ]
        
        
        Alamofire.request(.GET, api_url, parameters: params).validate().responseObject{ (response: Response<RecipeResponseObject, NSError>) in
            
            switch response.result{
            case .Success(let value):
                completionHandler(value as RecipeResponseObject, nil)
            case .Failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}


