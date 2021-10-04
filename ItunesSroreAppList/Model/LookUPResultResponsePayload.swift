//
//  SearchResultResponsePayload.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

import Foundation
import ObjectMapper
import RealmSwift

class LookUPResultResponsePayload: Object, Mappable{
    @objc dynamic var resultCount: Int = 0
    var results: [LookUPResultResponse]?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        resultCount <- map["resultCount"]
        results <- map["results"]
    }
}
