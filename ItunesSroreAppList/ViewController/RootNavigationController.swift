//
//  RootNavigationController.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 2/10/2021.
//

import UIKit

class RootNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appListViewController = storyboard?.instantiateViewController(withIdentifier: "AppListViewController") as? AppListViewController{
            albumListViewController.navigationController?.navigationBar.backItem?.hidesBackButton = true
            self.pushViewController(appListViewController, animated: true)
        }
        
        // Do any additional setup after loading the view.
    }
    


}
