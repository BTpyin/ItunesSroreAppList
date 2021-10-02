//
//  ResultPayload.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 2/10/2021.
//

import Foundation
import ObjectMapper
class ResultPayload:  Mappable {
    
    @objc dynamic var resultCount: Int = 0
    var results: [Album]?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        resultCount <- map["resultCount"]
        results <- map["results"]
    }
}
