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
        var top100AppFromRealm: Results<Top100ResultPayload>?
        var lookUpAppFromRealm: Results<LookUPResultResponse>?
    }

    struct Output {
        let appsRelay = BehaviorRelay<[Entry?]>(value:[])
    }

    struct InOut {
        
    }

    var input = Input()
    let output = Output()
    let inOut = InOut()

    init() {

    }
    
    func syncTop100App(completed: ((SyncDataFailReason?) -> Void)?){
        SyncData().syncTop100App(completed: completed)
        fetchTop100AppFromRealm()
    }
    
    func fetchTop100AppFromRealm(){
//        currentWeatherFromRealm = try? Realm().objects(WeatherResponse.self)
        input.top100AppFromRealm = try? Realm().objects(Top100ResultPayload.self)
//        output.appsRelay.accept(input.top10App0FromRealm?.first?.feed?.entries.toArray() ?? [])
        
    }
    
}
