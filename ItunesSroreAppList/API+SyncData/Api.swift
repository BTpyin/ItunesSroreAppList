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

  
  // MARK: - Common
  func stopAllRunningRequest() {
    Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
      tasks.forEach({ $0.cancel() })
    }
  }

    

    
}
