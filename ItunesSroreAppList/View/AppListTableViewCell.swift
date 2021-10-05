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
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        super.updateConstraints()
//        self.tableViewHeightConstraint?.constant = UIScreen.main.bounds.height - 200
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        top100AppListTableView.delegate = self
        top100AppListTableView.dataSource = self
//        self.top100AppListTableView.estimatedRowHeight = 200
//        self.top100AppListTableView.rowHeight = UITableView.automaticDimension
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
                })
            }
        }).disposed(by: disposeBag)
        
        viewModel.inOut.lookedUpAppsRelay.subscribe(onNext:{[weak self] _ in
            print("lookup realm list updated")
            self?.top100AppListTableView.reloadData()
        }).disposed(by: disposeBag)
        
//        Observable.changeset(from: (viewModel.input.lookUpAppFromRealm)!).subscribe(onNext: { results in
//            self.top100AppListTableView.reloadData()
//        }).disposed(by: disposeBag)
        
//        viewModel.output.appsRelay.subscribe(onNext: {[weak self] _ in
//            self?.top100AppListTableView.reloadData()
//
//        }).disposed(by: disposeBag)

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
        if viewModel.inOut.top100AppRelay.value.count != 0{
            return viewModel.inOut.lookedUpAppsRelay.value.count
        }else{
            return 0
        }
//        return viewModel.inOut.top100AppRelay.value.count
//        return currentItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Top100AppListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Top100AppListTableViewCell else {
          fatalError("The dequeued cell is not an instance of Top100AppListTableViewCell.")
        }
//        cell.uiBind(entry: viewModel.inOut.top100AppRelay.value[indexPath.row] ?? Entry(), itemNum: (indexPath.row + 1))
        
        var tmpLookupApp = try? Realm().objects(LookUPResultResponse.self).filter("trackID == %@", viewModel.inOut.top100AppRelay.value[indexPath.row]?.id?.attributes?.imID).first
//            return cell
//        }
//        cell.uiBind(app: app, itemNum: (indexPath.row + 1))
//        cell.uiBind(entry: viewModel.inOut.top100AppRelay.value[indexPath.row] ?? Entry(), itemNum: indexPath.row + 1)
        
        cell.uiBind(entry: viewModel.inOut.top100AppRelay.value[indexPath.row] ?? Entry(), itemNum: indexPath.row + 1, rating: tmpLookupApp?.averageUserRatingForCurrentVersion ?? 0, ratingCount: tmpLookupApp?.userRatingCountForCurrentVersion ?? 0)
//        cell.ratingView.isHidden = true
//        viewModel.lookUpApp(appId: , completed: <#T##((SyncDataFailReason?) -> Void)?##((SyncDataFailReason?) -> Void)?##(SyncDataFailReason?) -> Void#>)
        
        
        
        
        
        
        
//
//
        if indexPath.row == currentItems - 1{
            currentItems += 10
            viewModel.inOut.top100AppRelay.accept(viewModel.inOut.top100AppRelay.value)
//            self.top100AppListTableView.reloadData()
        }
        
        
//        if indexPath.row == privateList.count - 1 { // last cell
//            if totalItems > privateList.count { // more items to fetch
//                loadItem() // increment `fromIndex` by 20 before server call
//            }
//        }
        return cell
    }
}
