//
//  Api.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 2/10/2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RealmSwift
import SwiftyJSON
import ObjectMapper

class Api {
    static let requestBasePath = "https://itunes.apple.com/hk/"
//    static let apiKey = "95d190a434083879a6398aafd54d9e73"
//    static let imageLink = "http://openweathermap.org/img/wn/"


  
  // MARK: - Common
  func stopAllRunningRequest() {
    Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
      tasks.forEach({ $0.cancel() })
    }
  }

    

    
}
