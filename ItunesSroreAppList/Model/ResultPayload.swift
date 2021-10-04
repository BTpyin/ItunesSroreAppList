//
//  ResultPayload.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 2/10/2021.
//

import Foundation
import RealmSwift
import ObjectMapper

class Feed :  Object, Mappable{
//    var author: Author?
    var entries = List<Entry>()

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        var entries: [Entry]?
        entries <- map["entry"]
        if let entries = entries {
          for entry in entries {
            self.entries.append(entry)
          }
        }
    }

}




class Top10ResultPayload:  Object, Mappable {
    
    @objc dynamic var feed: Feed?
 

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        feed <- map["feed"]
        
    }
}

class Top100ResultPayload:  Object, Mappable {
    
    @objc dynamic var feed: Feed?
 

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        feed <- map["feed"]
        
    }
}
