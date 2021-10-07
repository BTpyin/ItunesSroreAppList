//
//  AppListTableViewCell.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class AppListTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var top100AppListTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var disposeBag = DisposeBag()
    var viewModel = AppListViewModel()
    var currentItems = 10
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        top100AppListTableView.delegate = self
        top100AppListTableView.dataSource = self

        self.tableViewHeightConstraint?.constant = UIScreen.main.bounds.height - 200
        
        viewModel.fetchLookedUpAppFromRealm()
        
        viewModel.inOut.top100AppRelay.subscribe(onNext:{ [weak self]_ in
//            self?.top100AppListTableView.reloadData()
            self?.layoutSubviews()
            if self?.viewModel.inOut.top100AppRelay.value.count != 0{
                self?.viewModel.fetchAppList(start: 0, end: self?.currentItems ?? 0, completed: {(failReason) in
                    if failReason != .none{
                        print(failReason?.localizedDescription)
                    }
                    let loadingDict = ["isLoading": false]
                    NotificationCenter.default.post(name: Notification.Name("isLoadingIndicator"), object: nil, userInfo: loadingDict)
                })
            }
        }).disposed(by: disposeBag)
        
        viewModel.inOut.lookedUpAppsRelay.subscribe(onNext:{[weak self] _ in
//            print("lookup realm list updated")
            self?.top100AppListTableView.reloadData()
        }).disposed(by: disposeBag)
        


    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.layoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.inOut.top100AppRelay.value.count != 0 && viewModel.inOut.lookedUpAppsRelay.value.count <= 100{
            return viewModel.inOut.lookedUpAppsRelay.value.count
        }else if viewModel.inOut.top100AppRelay.value.count != 0 && viewModel.inOut.lookedUpAppsRelay.value.count > 100{
            return 100
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Top100AppListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Top100AppListTableViewCell else {
          fatalError("The dequeued cell is not an instance of Top100AppListTableViewCell.")
        }
//        cell.uiBind(entry: viewModel.inOut.top100AppRelay.value[indexPath.row] ?? Entry(), itemNum: (indexPath.row + 1))
        
        var tmpLookupApp = try? Realm().objects(LookUPResultResponse.self).filter("trackID == %@", viewModel.inOut.top100AppRelay.value[indexPath.row]?.id?.attributes?.imID).first    
        cell.uiBind(entry: viewModel.inOut.top100AppRelay.value[indexPath.row] ?? Entry(), itemNum: indexPath.row + 1, rating: tmpLookupApp?.averageUserRatingForCurrentVersion ?? 0, ratingCount: tmpLookupApp?.userRatingCountForCurrentVersion ?? 0)

        if indexPath.row == currentItems - 1{
            if currentItems < viewModel.inOut.top100AppRelay.value.count {
                currentItems += 10
                let loadingDict = ["isLoading": true]
                NotificationCenter.default.post(name: Notification.Name("isLoadingIndicator"), object: nil, userInfo: loadingDict)
            }else{
                let loadingDict = ["isLoading": false]
                NotificationCenter.default.post(name: Notification.Name("isLoadingIndicator"), object: nil, userInfo: loadingDict)
            }
            viewModel.inOut.top100AppRelay.accept(viewModel.inOut.top100AppRelay.value)

//            self.top100AppListTableView.reloadData()
        }

        return cell
    }
}
