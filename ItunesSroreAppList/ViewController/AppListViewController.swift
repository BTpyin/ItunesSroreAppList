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

    

    @IBOutlet weak var serachBarTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    
    @IBOutlet weak var contentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
        contentTableView.delegate = self
        contentTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cellIdentifier = "Top10RecommendationTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Top10RecommendationTableViewCell else {
              fatalError("The dequeued cell is not an instance of Top10RecommendationTableViewCell.")
            }
            cell.viewModel.syncTop10App(completed: {[weak self](failReason) in
                self?.stopLoading()
                if let tempTop10Response = try? Realm().objects(Top10ResultPayload.self){
                    cell.top10RecommendationListCollectionView.reloadData()

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
        
    }
    


}
