//
//  Heroe.swift
//  MarvelHeroes
//
//  Created by Aina Cuxart on 21/5/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import SwiftyJSON

class Heroe {
    
    var id: Int
    var name: String
    var description: String
    var modified: String
    var thumbnail: Dictionary<String, Any>
    var resourceURI: String
    var comics: Dictionary<String, Any>
    var series: Dictionary<String, Any>
    var stories: Dictionary<String, Any>
    var events: Dictionary<String, Any>
    
    public init(){
        id = 0
        name = ""
        description = ""
        modified = ""
        thumbnail = Dictionary()
        resourceURI = ""
        comics = Dictionary()
        series = Dictionary()
        stories = Dictionary()
        events = Dictionary()
        
    }
    
    public init(id: Int, name: String, description: String, modified: String, thumbnail: Dictionary<String, Any>, resourceURI: String, comics: Dictionary<String, Any>, series: Dictionary<String, Any>, stories: Dictionary<String, Any>, events: Dictionary<String, Any>) {
        
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        
    }
    
    public init?(json: JSON) {
        id = Int(json["id"].intValue)
        name = json["name"].stringValue
        description = json["description"].stringValue
        modified = json["modified"].stringValue
        thumbnail = json["thumbnail"].dictionaryValue
        resourceURI = json["resourceURI"].stringValue
        comics = json["comics"].dictionaryValue
        series = json["series"].dictionaryValue
        stories = json["stories"].dictionaryValue
        events = json["events"].dictionaryValue
    }
    
}
