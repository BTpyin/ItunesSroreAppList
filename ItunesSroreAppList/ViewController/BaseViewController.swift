//
//  BaseViewController.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 2/10/2021.
//

import UIKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func startLoading() {
      loadingIndicator?.startAnimating()
      loadingIndicator?.isHidden = false
    }

    func stopLoading() {
      loadingIndicator?.isHidden = true
    }

    func isLoading() -> Bool {
      return !(loadingIndicator?.isHidden ?? true)
    }
    
//    func showErrorAlert(reason: SyncDataFailReason? = nil,
//                        showCache: Bool = false,
//                        okClicked: ((UIAlertAction) -> Void)? = nil) {
//      if reason == .network {
//        if showCache {
//          showAlert("Network_error_show_cache",
//                    okClicked: okClicked)
//        } else {
//          showAlert("Network_error",
//                    okClicked: okClicked)
//        }
//      } else if reason == .other ||
//        reason == .realmWrite ||
//        reason == nil {
//        showAlert("Error",
//                  okClicked: okClicked)
//      }
//    }

    
    func showAlert(_ title: String?, okClicked: ((UIAlertAction) -> Void)? = nil) {
      let alertVC = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction.init(title: "OK", style: .default, handler: okClicked))
      present(alertVC, animated: true, completion: nil)
    }

}

