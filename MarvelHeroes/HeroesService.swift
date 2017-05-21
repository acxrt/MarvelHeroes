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
import CryptoSwift


class HeroesService: NSObject {
    
    class func allHeroes(success:@escaping (Array<Any>) -> Void, failure:@escaping (Error) -> Void) {
        
        var url = ""
        
        if let path = Bundle.main.path(forResource: "MarvelAPIInfo", ofType: "plist") {
            let info = NSDictionary(contentsOfFile: path)!
            
            if let baseURL: String = info.object(forKey: "BaseURL") as! String?, let charactersUrl: String = info.object(forKey: "CharactersURL") as! String?, let publicKey: String = info.object(forKey: "PublicKey") as! String?, let privateKey: String = info.object(forKey: "PrivateKey") as! String? {
                
                let ts = "\(Date().millisecondsSince1970)"
                let text = ts+privateKey+publicKey
                let hash = text.md5()
                
                url = "\(baseURL)\(charactersUrl)ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
                
                print(baseURL)
                print(charactersUrl)
                print(publicKey)
                
                print(url)
            }
        }
        
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                let resJson = JSON(response.result.value!)
                let results = JSON(resJson["data"]["results"])
                var heroesList : Array<Heroe> = Array()
                
                for (_, subJson) in results {
                    let heroe = Heroe(json: subJson)!
                    heroesList.append(heroe)
                }
                
                success(heroesList)
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                
                failure(error)
            }
        }
    }
}

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}
