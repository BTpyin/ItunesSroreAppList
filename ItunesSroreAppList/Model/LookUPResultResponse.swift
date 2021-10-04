//
//  SearchResultResponse.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

import Foundation
class LookUPResultResponse {
    @objc dynamic var screenshotUrls: [String]?
    var ipadScreenshotUrls, appletvScreenshotUrls: [Any?]?
    var artworkUrl60, artworkUrl512, artworkUrl100: String?
    var artistViewURL: String?
    var features: [Any?]?
    var isGameCenterEnabled: Bool?
    var supportedDevices: [String]?
    var advisories: [Any?]?
    var kind, minimumOSVersion: String?
    var languageCodesISO2A: [String]?
    var averageUserRatingForCurrentVersion: Double?
    var userRatingCountForCurrentVersion: Int?
    var averageUserRating: Double?
    var trackContentRating, trackCensoredName: String?
    var trackViewURL: String?
    var contentAdvisoryRating, formattedPrice, fileSizeBytes, bundleID: String?
    var primaryGenreName: String?
    var genreIDS: [String]?
    var isVppDeviceBasedLicensingEnabled: Bool?
    var releaseDate: Date?
    var trackID: Int?
    var trackName, sellerName: String?
    var currentVersionReleaseDate: Date?
    var releaseNotes: String?
    var primaryGenreID: Int?
    var currency, welcomeDescription: String?
    var artistID: Int?
    var artistName: String?
    var genres: [String]?
    var price: Int?
    var version, wrapperType: String?
    var userRatingCount: Int?
}
