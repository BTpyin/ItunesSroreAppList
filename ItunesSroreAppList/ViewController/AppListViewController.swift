//
//  AppListViewController.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 3/10/2021.
//

import UIKit
import RxRealm
import RealmSwift
import Kingfisher

class AppListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    static var rowHeight :CGFloat = 0
    
    var viewModel = AppListViewModel()

    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var serachBarTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var contentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        startLoading()
        
        let loadingDict = ["isLoading": true]
        NotificationCenter.default.post(name: Notification.Name("isLoadingIndicator"), object: nil, userInfo: loadingDict)

        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        viewModel.syncTop10App(completed: nil)
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        serachBarTextField.rx.text.subscribe(onNext:{[weak self] in
            let inputText = "\($0 ?? "")"
            if $0 == ""{
                self?.searchResultTableView.isHidden = true
                self?.contentTableView.isHidden = false
            }else{
                self?.searchResultTableView.isHidden = false
                self?.contentTableView.isHidden = true
                let predicate = NSPredicate(format: "imName.label == %@", "\($0)")
                var searchList: [Entry]? = self?.viewModel.input.top100AppFromRealm?.first?.feed?.entries.filter { (app) -> Bool in
                    if app.imName?.label?.range(of: inputText, options: .caseInsensitive) != nil{
                        return true
                    }
                    return false
                }
                searchList?.append(contentsOf: self?.viewModel.input.top10AppFromRealm?.first?.feed?.entries.filter{ (app) -> Bool in
                    if app.imName?.label?.range(of: inputText, options: .caseInsensitive) != nil{
                        return true
                    }
                    return false
                } ?? [])
                
                for entity in searchList!{
                    self?.viewModel.lookUpApp(appId: entity.id?.attributes?.imID ?? "", completed: nil)
                }
                self?.viewModel.output.searchResultRelay.accept(searchList ?? [])
            }
        }).disposed(by: disposeBag)
        
        viewModel.output.searchResultRelay.subscribe(onNext:{[weak self]_ in
            self?.searchResultTableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.inOut.lookedUpAppsRelay.subscribe(onNext:{[weak self] _ in
//            print("lookup realm list updated")
            self?.searchResultTableView.reloadData()
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
        if tableView === searchResultTableView{
            return viewModel.output.searchResultRelay.value.count
        }else if tableView === contentTableView{
            return 2
        }else {
            fatalError("The table view is not found")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === searchResultTableView{
            let cellIdentifier = "SearchResultTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Top100AppListTableViewCell else {
              fatalError("The dequeued cell is not an instance of SearchResultTableViewCell.")
            }
            var tmpLookupApp = try? Realm().objects(LookUPResultResponse.self).filter("trackID == %@", viewModel.output.searchResultRelay.value[indexPath.row]?.id?.attributes?.imID).first
            
            cell.uiBind(entry: viewModel.output.searchResultRelay.value[indexPath.row] ?? Entry(), itemNum: indexPath.row + 1, rating: tmpLookupApp?.averageUserRatingForCurrentVersion ?? 0, ratingCount: tmpLookupApp?.userRatingCountForCurrentVersion ?? 0)

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
                let cellIdentifier = "AppListTableViewCell"
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AppListTableViewCell else {
                  fatalError("The dequeued cell is not an instance of AppListTableViewCell.")
                }

                return cell
            }
            
        }else {
            fatalError("The table view is not found")
        }
        
    }
    


}
