//
//  SearchResultResponse.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

import Foundation
import ObjectMapper
import RealmSwift


class LookUPResultResponse : Object, Mappable{
    
    
//    @objc dynamic var screenshotUrls: [String]?
//    @objc dynamic var ipadScreenshotUrls, appletvScreenshotUrls: [Any?]?
    @objc dynamic var artworkUrl60, artworkUrl512, artworkUrl100: String?
    @objc dynamic var artistViewURL: String?

    @objc dynamic var averageUserRatingForCurrentVersion: Double = 0
    @objc dynamic var userRatingCountForCurrentVersion: Int = 0
    @objc dynamic var averageUserRating: Double = 0
    @objc dynamic  var trackContentRating, trackCensoredName: String?
    @objc dynamic var trackViewURL: String?
//    @objc dynamic var contentAdvisoryRating, formattedPrice, fileSizeBytes, bundleID: String?
    @objc dynamic var primaryGenreName: String?
//    var genreIDS: [String]?
//    var isVppDeviceBasedLicensingEnabled: Bool?
//    var releaseDate: Date?
    @objc dynamic var trackID: String?
//    var trackName, sellerName: String?
    @objc dynamic var currentVersionReleaseDate: Date?
    @objc dynamic var releaseNotes: String?
    @objc dynamic var primaryGenreID: Int = 0
    @objc dynamic var currency, welcomeDescription: String?
    @objc dynamic var artistID: Int = 0
    @objc dynamic var artistName: String?
//    @objc dynamic var genres: [String]?
    @objc dynamic var price: Int = 0
//    var version, wrapperType: String?
    @objc dynamic var userRatingCount: Int = 0
    
    override static func primaryKey() -> String? {
      return "trackID"
    }
    
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        artworkUrl60 <- map["artworkUrl60"]
        artworkUrl512 <- map["artworkUrl512"]
        artworkUrl100 <- map["artworkUrl100"]
        artistViewURL <- map["artistViewUrl"]
        averageUserRatingForCurrentVersion <- map["averageUserRatingForCurrentVersion"]
        userRatingCountForCurrentVersion <- map["userRatingCountForCurrentVersion"]
        averageUserRating <- map["averageUserRating"]
        
        var id : Int = 0
        id <- map["trackId"]
        trackID = "\(id)"
        
        trackContentRating <- map["trackContentRating"]
        trackCensoredName <- map["trackCensoredName"]
        trackViewURL <- map["trackViewUrl"]
        primaryGenreName <- map["primaryGenreName"]
        currentVersionReleaseDate <- map["currentVersionReleaseDate"]
        releaseNotes <- map["releaseNotes"]
        primaryGenreID <- map["primaryGenreID"]
        currency <- map["currency"]
        welcomeDescription <- map["welcomeDescription"]
        artistID <- map["artistID"]
        artistName <- map["artistName"]
        price <- map["price"]
        userRatingCount <- map["userRatingCount"]
//        artistName <- map["artistName"]
    }
}


extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}
