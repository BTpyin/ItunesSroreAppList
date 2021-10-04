//
//  Too100AppObject.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 3/10/2021.
//

import Foundation
import ObjectMapper
import RealmSwift


// MARK: - Entry
class Entry : Object, Mappable{
    @objc dynamic var imName: IMName?
    var imImage = List<IMImage>()
    @objc dynamic var summary: IMName?
    @objc dynamic var imPrice: IMPrice?
//    var imContentType: IMContentType?
    @objc dynamic var rights, title: IMName?
//    var link: [Link]?
    @objc dynamic var id: ID?
    @objc dynamic var imArtist: IMArtist?
    @objc dynamic var category: Category?
    @objc dynamic var imReleaseDate: IMReleaseDate?

//    init(imName: IMName?, imImage: [IMImage]?, summary: IMName?, imPrice: IMPrice?,rights: IMName?, title: IMName?, imArtist: IMArtist?, category: Category?, imReleaseDate: IMReleaseDate?) {
//        self.imName = imName
//        self.imImage = imImage
//        self.summary = summary
//        self.imPrice = imPrice
////        self.imContentType = imContentType
//        self.rights = rights
//        self.title = title
////        self.link = link
////        self.id = id
//        self.imArtist = imArtist
//        self.category = category
//        self.imReleaseDate = imReleaseDate
//    }
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        imName <- map["im:name"]
        
        var imImage: [IMImage]?
        
        imImage <- map["im:image"]
        if let imImage = imImage {
          for image in imImage {
            self.imImage.append(image)
          }
        }

        imPrice <- map["im:price"]
        rights <- map["rights"]
        title <- map["title"]
        summary <- map["summary"]
        imArtist <- map["im:artist"]
        category <- map["category"]
        imReleaseDate <- map ["im:releaseDate"]
        id <- map["id"]
        
    }
}

// MARK: - Category
class Category : Object, Mappable {
    @objc dynamic var attributes: CategoryAttributes?

//    init(attributes: CategoryAttributes?) {
//        self.attributes = attributes
//    }
//
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        attributes <- map ["attributes"]
    }
    
}

// MARK: - CategoryAttributes
class CategoryAttributes: Object, Mappable  {
    @objc dynamic var imID, term: String?
    @objc dynamic var scheme: String?
    @objc dynamic var label: String?
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        imID <- map ["im:id"]
        term <- map ["term"]
        scheme <- map ["scheme"]
        label <- map ["label"]
    }

//    init(imID: String?, term: String?, scheme: String?, label: String?) {
//        self.imID = imID
//        self.term = term
//        self.scheme = scheme
//        self.label = label
//    }
}

// MARK: - ID
class ID : Object, Mappable   {
    @objc dynamic var label: String?
    @objc dynamic var attributes: IDAttributes?

//    init(label: String?, attributes: IDAttributes?) {
//        self.label = label
//        self.attributes = attributes
//    }
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        label <- map ["label"]
        attributes <- map ["attributes"]
    }
}

// MARK: - IDAttributes
class IDAttributes : Object, Mappable  {
    @objc dynamic var imID, imBundleID: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        imID <- map ["im:id"]
        imBundleID <- map ["im:bundleId"]
    }
    
}

// MARK: - IMArtist
class IMArtist : Object, Mappable {
    @objc dynamic var label: String?
    @objc dynamic var attributes: IMArtistAttributes?

//    init(label: String?, attributes: IMArtistAttributes?) {
//        self.label = label
//        self.attributes = attributes
//    }
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        label <- map ["label"]
        attributes <- map["attributes"]
    }
}

// MARK: - IMArtistAttributes
class IMArtistAttributes : Object, Mappable {
    
    @objc dynamic var href: String?

//    init(href: String?) {
//        self.href = href
//    }
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        href <- map ["href"]
    }
}

// MARK: - IMContentType
//class IMContentType {
//    var attributes: IMContentTypeAttributes?
//
//    init(attributes: IMContentTypeAttributes?) {
//        self.attributes = attributes
//    }
//}

// MARK: - IMContentTypeAttributes
//class IMContentTypeAttributes {
//    var term, label: String?
//
//    init(term: String?, label: String?) {
//        self.term = term
//        self.label = label
//    }
//}

// MARK: - IMImage
class IMImage  : Object, Mappable {
    @objc dynamic var label: String?
    @objc dynamic var attributes: IMImageAttributes?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        label <- map ["label"]
        attributes <- map ["attributes"]
    }
    
}

// MARK: - IMImageAttributes
class IMImageAttributes : Object, Mappable {
    @objc dynamic var height: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        height <- map ["height"]
    }
}

// MARK: - IMName
class IMName : Object, Mappable {
    
    @objc dynamic var label: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        label <- map ["label"]
    }
}

// MARK: - IMPrice
class IMPrice  : Object, Mappable{
    
    @objc dynamic var label: String?
    @objc dynamic var attributes: IMPriceAttributes?

    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        label <- map["label"]
        attributes <- map["attributes"]
    }
}

// MARK: - IMPriceAttributes
class IMPriceAttributes : Object, Mappable{
    
    @objc dynamic var amount, currency: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        amount <- map ["amount"]
        currency <- map ["currency"]
    }
}

// MARK: - IMReleaseDate
class IMReleaseDate : Object, Mappable{
    
    @objc dynamic var label: Date?
    @objc dynamic var attributes: IMName?

//    init(label: Date?, attributes: IMName?) {
//        self.label = label
//        self.attributes = attributes
//    }
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        label <- map ["label"]
        attributes <- map ["attributes"]
    }
    
}

// MARK: - Link
//class Link {
//    var attributes: LinkAttributes?
//    var imDuration: IMName?
//
//    init(attributes: LinkAttributes?, imDuration: IMName?) {
//        self.attributes = attributes
//        self.imDuration = imDuration
//    }
//}
//
//// MARK: - LinkAttributes
//class LinkAttributes {
//    var rel: Rel?
//    var type: TypeEnum?
//    var href: String?
//    var title, imAssetType: String?
//
//    init(rel: Rel?, type: TypeEnum?, href: String?, title: String?, imAssetType: String?) {
//        self.rel = rel
//        self.type = type
//        self.href = href
//        self.title = title
//        self.imAssetType = imAssetType
//    }
//}
//
//enum Rel {
//    case alternate
//    case enclosure
//}
//
//enum TypeEnum {
//    case imageJPEG
//    case textHTML
//}
