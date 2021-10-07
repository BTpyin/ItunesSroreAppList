//
//  AppListViewController.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 3/10/2021.
//

import UIKit
import RxRealm
import RxCocoa
import RealmSwift
import Kingfisher

class AppListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    static var rowHeight :CGFloat = 0
    
    var viewModel = AppListViewModel()

    @IBOutlet weak var serachBarTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var searchedAppResultTableView: UITableView!
    @IBOutlet weak var contentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        startLoading()
        
        let loadingDict = ["isLoading": true]
        NotificationCenter.default.post(name: Notification.Name("isLoadingIndicator"), object: nil, userInfo: loadingDict)

        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        searchedAppResultTableView.delegate = self
        searchedAppResultTableView.dataSource = self
        
        viewModel.syncTop10App(completed: nil)
        viewModel.fetchLookedUpAppFromRealm()
//        serachBarTextField.rx.text.asObservable().subscribe(onNext:{ [weak self] in
////            let searchText = "\($0)"
//            if $0 == ""{
//                self?.searchedAppResultTableView.isHidden = true
//                self?.contentTableView.isHidden = false
//            }else{
//                self?.contentTableView.isHidden = true
//                self?.searchedAppResultTableView.isHidden = false
//                let predicate = NSPredicate(format: "imName.label == %@", "\($0)")
//                var searchList = self?.viewModel.input.top100AppFromRealm?.first?.feed?.entries.filter(predicate).toArray()
//                searchList?.append(contentsOf: self?.viewModel.input.top10AppFromRealm?.first?.feed?.entries.filter(predicate).toArray() ?? [])
//                self?.viewModel.output.searchResultRelay.accept(searchList ?? [])
//            }
//        }).disposed(by: disposeBag)
        
        viewModel.output.searchResultRelay.subscribe(onNext:{[weak self]_ in
            self?.searchedAppResultTableView.reloadData()
        }).disposed(by: disposeBag)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleMassage),
                                               name: Notification.Name("isLoadingIndicator"),
                                               object: nil)
    }
    
    @objc func handleMassage(notification: NSNotification) {
        if let dict = notification.userInfo as? NSDictionary {
            if let myMessage = dict["isLoading"] as? Bool{
                if myMessage {
                    startLoading()
                    loadingView.isHidden = false
                }else{
                    stopLoading()
                    loadingView.isHidden = true
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         return UITableView.automaticDimension
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === searchedAppResultTableView{
            if viewModel.inOut.top100AppRelay.value.count != 0{
                return viewModel.output.appsRelay.value.count
            }else {
                return 0
            }
        }else if tableView === contentTableView{
            return 2
        }else{
            fatalError("table view is missed")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === searchedAppResultTableView{
            let cellIdentifier = "AppListTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AppListTableViewCell else {
              fatalError("The dequeued cell is not an instance of AppListTableViewCell.")
            }

            return cell
        }else if tableView === contentTableView{
            if indexPath.row == 0{
                let cellIdentifier = "Top10RecommendationTableViewCell"
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Top10RecommendationTableViewCell else {
                  fatalError("The dequeued cell is not an instance of Top10RecommendationTableViewCell.")
                }
                cell.viewModel.syncTop10App(completed: {[weak self](failReason) in
                    self?.stopLoading()
                    if let tempTop10Response = try? Realm().objects(Top10ResultPayload.self){
                        cell.top10RecommendationListCollectionView.reloadData()
                        AppListViewController.rowHeight = cell.frame.height
                    }else{
                        self?.showErrorAlert(reason: failReason, showCache: true, okClicked: nil)

                    }
                    print(failReason?.localizedDescription)
                })
                return cell
            }else{
                let cellIdentifier = "SearchedAppResultTableViewCell"
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Top100AppListTableViewCell else {
                  fatalError("The dequeued cell is not an instance of AppListTableViewCell.")
                }
                var tmpLookupApp = try? Realm().objects(LookUPResultResponse.self).filter("trackID == %@", viewModel.output.searchResultRelay.value[indexPath.row]?.id?.attributes?.imID).first
                
                cell.uiBind(entry: viewModel.output.searchResultRelay.value[indexPath.row] ?? Entry(), itemNum: indexPath.row + 1, rating: tmpLookupApp?.averageUserRatingForCurrentVersion ?? 0, ratingCount: tmpLookupApp?.userRatingCountForCurrentVersion ?? 0)
                return cell
            }
        }else{
            fatalError("table view is missed")
        }
    }
    


}
