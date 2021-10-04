//
//  SyncDataToRealm.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 2/10/2021.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

enum SyncDataFailReason: Error {
  case network
  case realmWrite
  case other
}


class SyncData {
    static var firstSync : Bool  = false
    
    static var realmBackgroundQueue = DispatchQueue(label: ".realm", qos: .background)
    
    static func writeRealmAsync(_ write: @escaping (_ realm: Realm) -> Void,
                                completed: (() -> Void)? = nil) {
      SyncData.realmBackgroundQueue.async {
        autoreleasepool {
          do {
            let realm = try Realm()
            realm.beginWrite()
            write(realm)
            try realm.commitWrite()

            if let completed = completed {
              DispatchQueue.main.async {
                let mainThreadRealm = try? Realm()
                mainThreadRealm?.refresh() // Get updateds from Background thread
                completed()
              }
            }
      } catch {
            print("writeRealmAsync Exception \(error)")
          }
        }
      }
    }
    
    func failReason(error: Error?, resposne: Any?) -> SyncDataFailReason {
      if let error = error as NSError?, error.domain == NSURLErrorDomain {
        return .network
      }
      return .other
    }
    
    func searchApp(keyword: String, completed :((SyncDataFailReason?) -> Void)?){
        
    }
    
    func lookUpApp(appId: String, completed: ((SyncDataFailReason?) -> Void)?){
        let urlString = "\(Api.requestBasePath)lookup?id=\(appId)"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
         {
            Alamofire.request(url, method: .post, encoding: URLEncoding.default, headers: nil).responseObject{ (response: DataResponse<LookUPResultResponsePayload>)  in
//                print(response.value)
//                print(response.error.debugDescription)
//                print(url)
                guard let lookUpResponse = response.result.value else{
                    completed?(.network)
                    return
                }
                guard let data = lookUpResponse.results?.first else {
                    completed?(.network)
                    return
                }
                let predicate = NSPredicate(format: "trackID = %@", appId)
//                print((weatherResponse).weatherMain?.feels_like)
                SyncData.writeRealmAsync({ (realm) in
//                    realm.delete(realm.objects(LookUPResultResponse.self))
//                    realm.delete(realm.objects(LookUPResultResponse.self).filter(predicate))
                    realm.add(data)
                    
//                    print(realm.objects(WeatherResponse.self).first3.
                    
                }, completed:{
                    completed?(.realmWrite)
                  })
            }
        }
    }
    
    
    
    func syncTop100App(completed:((SyncDataFailReason?) -> Void)?) {
        
        let urlString = "\(Api.requestBasePath)rss/topfreeapplications/limit=100/json"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
         {
            Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil).responseObject{ (response: DataResponse<Top100ResultPayload>)  in
//                print(response.value)
//                print(response.error.debugDescription)
//                print(url)
                guard let Top100Response = response.result.value else{
                    completed?(.network)
                    return
                }
//                print((weatherResponse).weatherMain?.feels_like)
                SyncData.writeRealmAsync({ (realm) in
                    realm.delete(realm.objects(Top100ResultPayload.self))
                    realm.add(Top100Response)
//                    print(realm.objects(WeatherResponse.self).first3.
                    
                }, completed:{
                    completed?(.realmWrite)
                  })
            }
        }
    }
    
    func syncTop10App(completed:((SyncDataFailReason?) -> Void)?) {
        
        let urlString = "\(Api.requestBasePath)rss/topgrossingapplications/limit=10/json"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
         {
            Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil).responseObject{ (response: DataResponse<Top10ResultPayload>)  in
//                print(response.value)
//                print(response.error.debugDescription)
//                print(url)
                guard let top10Response = response.result.value else{
                    completed?(.network)
                    return
                }
//                print((weatherResponse).weatherMain?.feels_like)
                SyncData.writeRealmAsync({ (realm) in
                    realm.delete(realm.objects(Top10ResultPayload.self))
                    realm.add(top10Response)
//                    print(realm.objects(WeatherResponse.self).first)
                }, completed:{
                    completed?(.realmWrite)
                  })
            }
        }
    }
    
    
}
