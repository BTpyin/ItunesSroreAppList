//
//  Top10RecommendationTavleViewCellViewModel.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift


class Top10RecommendationTavleViewCellViewModel:ViewModelType{
    var disposeBag = DisposeBag()

    var data = ""
    struct Input {
        var top10AppFromRealm: Results<Top10ResultPayload>?
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
        fetchTop10AppFromRealm()
    }
    
    func syncTop10App(completed: ((SyncDataFailReason?) -> Void)?){
        SyncData().syncTop10App(completed: { _ in
                                    self.fetchTop10AppFromRealm()
                                    completed
            
        })
        
    }
    
    func fetchTop10AppFromRealm(){
//        currentWeatherFromRealm = try? Realm().objects(WeatherResponse.self)
        input.top10AppFromRealm = try? Realm().objects(Top10ResultPayload.self)
        output.appsRelay.accept(input.top10AppFromRealm?.first?.feed?.entries.toArray() ?? [])
        
    }
}
