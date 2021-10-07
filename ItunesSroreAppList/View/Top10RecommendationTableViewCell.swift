//
//  Top10RecommendationTableViewCell.swift
//  ItunesSroreAppList
//
//  Created by Bowie Tso on 4/10/2021.
//

import UIKit
import RxSwift
import RealmSwift

class Top10RecommendationTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var viewModel = Top10RecommendationTavleViewCellViewModel()
    var disposeBag = DisposeBag()

    @IBOutlet weak var top10RecommendationListCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        top10RecommendationListCollectionView.delegate = self
        top10RecommendationListCollectionView.dataSource = self
        
        viewModel.output.appsRelay.subscribe(onNext:{_ in
            self.top10RecommendationListCollectionView.reloadData()
            
        }).disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.appsRelay.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "Top10RecommendationCollectionViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? Top10RecommendationCollectionViewCell else {
          fatalError("The dequeued cell is not an instance of Top10RecommendationCollectionViewCell.")
        }

        cell.uiBind(app: viewModel.output.appsRelay.value[indexPath.row] ?? Entry())
        return cell
    }
    

}



