//
//  Top10RecommendationCollectionViewCell.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class Top10RecommendationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    func initUI(){
    
        appImageView.clipsToBounds = true
        appImageView.contentMode = .scaleAspectFill
        appImageView.roundCorners(cornerRadius: 10)
        
        appNameLabel.font.withSize(15)
        appNameLabel.textColor = .black
        
        appCategoryLabel.font.withSize(15)
        appCategoryLabel.textColor = .darkGray
    }
    
    func uiBind(app: Entry){
        appImageView.kf.setImage(with: URL(string: app.imImage?.last?.label ?? ""))
        appNameLabel.text = app.imName?.label
        appCategoryLabel.text = app.category?.attributes?.label
    }
}
