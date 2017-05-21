//
//  HeroesService.swift
//  MarvelHeroes
//
//  Created by Aina Cuxart on 21/5/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HeroesService: NSObject {
    
    class func allHeroes(success:@escaping (Array<Any>) -> Void, failure:@escaping (Error) -> Void) {
        
        var url = ""
        
        if let path = Bundle.main.path(forResource: "MarvelAPIInfo", ofType: "plist") {
            let info = NSDictionary(contentsOfFile: path)!
            
            if let baseURL: String = info.object(forKey: "BaseURL") as! String?, let charactersUrl: String = info.object(forKey: "CharactersURL") as! String?, let publicKey: String = info.object(forKey: "PublicKey") as! String? {
                url = "\(baseURL)\(charactersUrl)apikey=\(publicKey)"
                
                print(baseURL)
                print(charactersUrl)
                print(publicKey)
                
                print(url)
            }
            
            
        }
        
    
        
//        Alamofire.request("url").responseJSON { response in
//            if response.result.isSuccess {
//                let resJson = JSON(response.result.value!)
//                var heroesList : Array<OompaLoopma> = Array()
//                
//                for (_, subJson) in resJson {
//                    let heroe = OompaLoopma(json: subJson)!
//                    heroesList.append(heroe)
//                }
//                
//                success(heroeList)
//            }
//            if response.result.isFailure {
//                let error : Error = response.result.error!
//                
//                failure(error)
//            }
//            
//            if let JSON = response.result.value {
////                print("JSON: \(JSON)")
//            }
//        }
    }

    
    
}
