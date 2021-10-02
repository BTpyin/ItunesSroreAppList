//
//  UIViewRoundCornerExtension.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 2/10/2021.
//

import UIKit

extension UIView {
  func roundCorners(cornerRadius: Double) {
    self.layer.cornerRadius = CGFloat(cornerRadius)
    self.clipsToBounds = true
  }
}
