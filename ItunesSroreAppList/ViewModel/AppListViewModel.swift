//
//  AppListViewModel.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class AppListViewModel: ViewModelType{
    var disposeBag = DisposeBag()

    struct Input {
        var top10AppFromRealm: Results<Top10ResultPayload>?
        var top100AppFromRealm: Results<Top100ResultPayload>?
        var lookUpAppFromRealm: Results<LookUPResultResponse>?
        
    }

    struct Output {
        let appsRelay = BehaviorRelay<[CustomAppListObject?]>(value:[])
        let top10AppsRelay = BehaviorRelay<[Entry?]>(value:[])
    }

    struct InOut {
        let top100AppRelay = BehaviorRelay<[Entry?]>(value:[])
        let lookedUpAppsRelay = BehaviorRelay<[LookUPResultResponse?]>(value:[])
    }

    var input = Input()
    let output = Output()
    let inOut = InOut()

    init() {
        syncTop100App(completed: nil)
        fetchLookedUpAppFromRealm()
        fetchTop10AppFromRealm()
    }
    
    func syncTop10App(completed: ((SyncDataFailReason?) -> Void)?){
        SyncData().syncTop10App(completed: completed)
        fetchTop10AppFromRealm()
    }
    
    func fetchTop10AppFromRealm(){
//        currentWeatherFromRealm = try? Realm().objects(WeatherResponse.self)
        input.top10AppFromRealm = try? Realm().objects(Top10ResultPayload.self)
        output.top10AppsRelay.accept(input.top10AppFromRealm?.first?.feed?.entries.toArray() ?? [])
        
    }
    
    func syncTop100App(completed: ((SyncDataFailReason?) -> Void)?){
        
        SyncData().syncTop100App(completed: completed)
        fetchTop100AppFromRealm()
    }
    
    func fetchTop100AppFromRealm(){
//        currentWeatherFromRealm = try? Realm().objects(WeatherResponse.self)
        input.top100AppFromRealm = try? Realm().objects(Top100ResultPayload.self)
        inOut.top100AppRelay.accept(input.top100AppFromRealm?.first?.feed?.entries.toArray() ?? [])
        
    }
    
    func lookUpApp(appId : String, completed: ((SyncDataFailReason?) -> Void)?){
        SyncData().lookUpApp(appId: appId, completed: {_ in
            self.fetchLookedUpAppFromRealm()
            completed?(nil)
        })
        
    }
    
    
    func fetchLookedUpAppFromRealm(){
//        currentWeatherFromRealm = try? Realm().objects(WeatherResponse.self)
        input.lookUpAppFromRealm = try? Realm().objects(LookUPResultResponse.self)
        inOut.lookedUpAppsRelay.accept(input.lookUpAppFromRealm?.toArray() ?? [])
        
    }
    
    func fetchAppList(start: Int, end: Int, completed: ((SyncDataFailReason?) -> Void)?){
        if end == 0 {
            completed?(.network)
            
        }
        var tempAppList = [CustomAppListObject]()
        for index in start...end{
            lookUpApp(appId: inOut.top100AppRelay.value[index]?.id?.attributes?.imID ?? "", completed: completed)
        }
//        output.appsRelay.accept(tempAppList)
    }
    
}
