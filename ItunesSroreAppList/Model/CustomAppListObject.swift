//
//  CustomAppListObject.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

//import Foundation
//import RealmSwift
//
//class CustomAppListObject: Object {
//
//    @objc dynamic var appId : String?
//    var rating : Double = 0
//    @objc dynamic var name: String?
//    @objc dynamic var appCategory : String?
//    @objc dynamic var imageLink : String?
//    var itemNumber : Int = 0
//    var ratingCount: Int = 0
//
//    required convenience init(lookUpResponse: LookUPResultResponse, entry:Entry){
//        self.init()
//        rating = lookUpResponse.averageUserRating ?? 0
//        ratingCount = lookUpResponse.userRatingCount ?? 0
//        name = entry.imName?.label
//        appId = entry.id?.attributes?.imID
//        appCategory = entry.category?.attributes?.label
//        imageLink = entry.imImage.last?.label
//    }
//}
