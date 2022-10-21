//
//  SavedViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 21.10.2022.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import SDWebImage

class SavedViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var detailCollection: UICollectionView!
    
    private var viewModel = SavedViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindSavedCollectionCell()
        registerCell()
       
    }
    
    
    private func bindSavedCollectionCell() {
        
        self.viewModel.fetchData()
        print("2::\(viewModel.fetchData())")
        detailCollection.rx.setDelegate(self).disposed(by: bag)
        viewModel.savedGameBehavior.bind(to: detailCollection.rx.items(cellIdentifier: "", cellType: SavedCollectionViewCell.self)) {
            section, item, cell in
            cell.savedGameName.text = "item.name"
            
        }.disposed(by: bag)
  
    }
   
    private func registerCell() {
        
        detailCollection.register(UINib(nibName: "SavedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SavedCollectionViewCell")
    }

}

