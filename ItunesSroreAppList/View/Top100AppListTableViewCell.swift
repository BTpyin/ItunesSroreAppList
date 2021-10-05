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
    @IBOutlet weak var ratingStackView: UIStackView!
    var ratingCountLabel: UILabel?
    @IBOutlet weak var ratingStarStackView: UIStackView!
    
    var imageViewList = [UIImageView]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        // Initialization code
    }

    func initUI(){
        appNameLabel.font.withSize(13)
        appNameLabel.textColor = .black
        
        appCatLabel.font.withSize(9)
        appCatLabel.textColor = .darkGray
        
        ratingCountLabel = UILabel()
        ratingCountLabel?.font.withSize(8)
        ratingCountLabel?.textColor = .darkGray
        
        for index in 0...4{
            imageViewList.append(UIImageView())
            imageViewList[index].frame.size = CGSize(width: 7, height: 7)
            imageViewList[index].tintColor = .systemYellow
            
        }
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
            appImageView.roundCorners(cornerRadius: (Double(appImageView.frame.height) / 2))
        }else{
            //odd Number
            appImageView.roundCorners(cornerRadius: 15)
        }
 
    }
    
    func uiBind(entry:Entry, itemNum: Int?, rating: Double, ratingCount: Int){
        var tmpRating = rating.round(nearest: 0.5)
        appImageView.kf.setImage(with: URL(string: entry.imImage.last?.label ?? ""))
        appNameLabel.text = entry.imName?.label
        appCatLabel.text = entry.category?.attributes?.label
        itemNumberLabel.text = "\(itemNum ?? 0)"
        ratingCountLabel?.text = "(\(ratingCount))"
        guard let itemNum = itemNum else {return}
        if (itemNum % 2) == 0{
            //even Number
            appImageView.roundCorners(cornerRadius: (Double(appImageView.frame.height) / 2))
        }else{
            //odd Number
            appImageView.roundCorners(cornerRadius: 15)
        }
        
        for index in 0...4{
            if tmpRating > 0.5{
                imageViewList[index].image = UIImage(systemName: "star.fill")
            }else if tmpRating == 0.5{
                imageViewList[index].image = UIImage(systemName: "star.leadinghalf.fill")
                tmpRating -= 0.5
                ratingStarStackView.addArrangedSubview(imageViewList[index])
                continue
            }else{
                imageViewList[index].image = UIImage(systemName: "star")
            }
            tmpRating-=1
            ratingStarStackView.addArrangedSubview(imageViewList[index])
        }
        
        ratingStackView.addArrangedSubview(ratingCountLabel ?? UILabel())
        
    }
    
    func uiBind(app: CustomAppListObject, itemNum: Int?){
        appImageView.kf.setImage(with: URL(string: app.imageLink ?? ""))
        appNameLabel.text = app.name
        appCatLabel.text = app.appCategory
        itemNumberLabel.text = "\(itemNum ?? 0)"
        guard let itemNum = itemNum else {return}
        if (itemNum % 2) == 0{
            //even Number
            appImageView.roundCorners(cornerRadius: (Double(appImageView.frame.height) / 2))
        }else{
            //odd Number
            appImageView.roundCorners(cornerRadius: 15)
        }
    }

}
