//
//  Top100AppListTableViewCell.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

import UIKit
import Kingfisher

class Top100AppListTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNumberLabel: UILabel!
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appCatLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initUI(){
    }
    
    func uiBind(entry:Entry, itemNum: Int?){
        appImageView.kf.setImage(with: URL(string: entry.imImage.last?.label ?? ""))
        appNameLabel.text = entry.imName?.label
        appCatLabel.text = entry.category?.attributes?.label
        itemNumberLabel.text = "\(itemNum ?? 0)"
        ratingView.isHidden = true
        guard let itemNum = itemNum else {return}
        if (itemNum % 2) == 0{
            //even Number
            appImageView.roundCorners(cornerRadius: 37.5)
        }else{
            //odd Number
            appImageView.roundCorners(cornerRadius: 15)
        }
    }
    
    func uiBind(entry:Entry, itemNum: Int?, rating: Double, ratingCount: Int){
        appImageView.kf.setImage(with: URL(string: entry.imImage.last?.label ?? ""))
        appNameLabel.text = entry.imName?.label
        appCatLabel.text = entry.category?.attributes?.label
        itemNumberLabel.text = "\(itemNum ?? 0)"
        ratingCountLabel.text = "(\(ratingCount)"
        guard let itemNum = itemNum else {return}
        if (itemNum % 2) == 0{
            //even Number
            appImageView.roundCorners(cornerRadius: 37.5)
        }else{
            //odd Number
            appImageView.roundCorners(cornerRadius: 15)
        }
        
    }
    
    func uiBind(app: CustomAppListObject, itemNum: Int?){
        appImageView.kf.setImage(with: URL(string: app.imageLink ?? ""))
        appNameLabel.text = app.name
        appCatLabel.text = app.appCategory
        itemNumberLabel.text = "\(itemNum ?? 0)"
        guard let itemNum = itemNum else {return}
        if (itemNum % 2) == 0{
            //even Number
            appImageView.roundCorners(cornerRadius: 37.5)
        }else{
            //odd Number
            appImageView.roundCorners(cornerRadius: 15)
        }
    }

}
