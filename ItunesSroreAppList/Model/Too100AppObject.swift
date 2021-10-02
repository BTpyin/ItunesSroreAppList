//
//  Too100AppObject.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 3/10/2021.
//

import Foundation



// MARK: - Entry
class Entry {
    var imName: IMName?
    var imImage: [IMImage]?
    var summary: IMName?
    var imPrice: IMPrice?
//    var imContentType: IMContentType?
    var rights, title: IMName?
    var link: [Link]?
//    var id: ID?
    var imArtist: IMArtist?
    var category: Category?
    var imReleaseDate: IMReleaseDate?

    init(imName: IMName?, imImage: [IMImage]?, summary: IMName?, imPrice: IMPrice?,rights: IMName?, title: IMName?, link: [Link]?, imArtist: IMArtist?, category: Category?, imReleaseDate: IMReleaseDate?) {
        self.imName = imName
        self.imImage = imImage
        self.summary = summary
        self.imPrice = imPrice
//        self.imContentType = imContentType
        self.rights = rights
        self.title = title
        self.link = link
//        self.id = id
        self.imArtist = imArtist
        self.category = category
        self.imReleaseDate = imReleaseDate
    }
}

// MARK: - Category
class Category {
    var attributes: CategoryAttributes?

    init(attributes: CategoryAttributes?) {
        self.attributes = attributes
    }
}

// MARK: - CategoryAttributes
class CategoryAttributes {
    var imID, term: String?
    var scheme: String?
    var label: String?

    init(imID: String?, term: String?, scheme: String?, label: String?) {
        self.imID = imID
        self.term = term
        self.scheme = scheme
        self.label = label
    }
}

// MARK: - ID
//class ID {
//    var label: String?
//    var attributes: IDAttributes?
//
//    init(label: String?, attributes: IDAttributes?) {
//        self.label = label
//        self.attributes = attributes
//    }
//}
//
// MARK: - IDAttributes
//class IDAttributes {
//    var imID, imBundleID: String?
//
//    init(imID: String?, imBundleID: String?) {
//        self.imID = imID
//        self.imBundleID = imBundleID
//    }
//}

// MARK: - IMArtist
class IMArtist {
    var label: String?
    var attributes: IMArtistAttributes?

    init(label: String?, attributes: IMArtistAttributes?) {
        self.label = label
        self.attributes = attributes
    }
}

// MARK: - IMArtistAttributes
class IMArtistAttributes {
    var href: String?

    init(href: String?) {
        self.href = href
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
class IMImage {
    var label: String?
    var attributes: IMImageAttributes?

    init(label: String?, attributes: IMImageAttributes?) {
        self.label = label
        self.attributes = attributes
    }
}

// MARK: - IMImageAttributes
class IMImageAttributes {
    var height: String?

    init(height: String?) {
        self.height = height
    }
}

// MARK: - IMName
class IMName {
    var label: String?

    init(label: String?) {
        self.label = label
    }
}

// MARK: - IMPrice
class IMPrice {
    var label: String?
    var attributes: IMPriceAttributes?

    init(label: String?, attributes: IMPriceAttributes?) {
        self.label = label
        self.attributes = attributes
    }
}

// MARK: - IMPriceAttributes
class IMPriceAttributes {
    var amount, currency: String?

    init(amount: String?, currency: String?) {
        self.amount = amount
        self.currency = currency
    }
}

// MARK: - IMReleaseDate
class IMReleaseDate {
    var label: Date?
    var attributes: IMName?

    init(label: Date?, attributes: IMName?) {
        self.label = label
        self.attributes = attributes
    }
}

// MARK: - Link
class Link {
    var attributes: LinkAttributes?
    var imDuration: IMName?

    init(attributes: LinkAttributes?, imDuration: IMName?) {
        self.attributes = attributes
        self.imDuration = imDuration
    }
}

// MARK: - LinkAttributes
class LinkAttributes {
    var rel: Rel?
    var type: TypeEnum?
    var href: String?
    var title, imAssetType: String?

    init(rel: Rel?, type: TypeEnum?, href: String?, title: String?, imAssetType: String?) {
        self.rel = rel
        self.type = type
        self.href = href
        self.title = title
        self.imAssetType = imAssetType
    }
}

enum Rel {
    case alternate
    case enclosure
}

enum TypeEnum {
    case imageJPEG
    case textHTML
}
