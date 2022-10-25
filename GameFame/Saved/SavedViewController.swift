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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.fetchData()
        
    }
    
    
    private func registerCell() {
        
        detailCollection.register(UINib(nibName: "SavedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SavedCollectionViewCell")
    }
    
}

extension SavedViewController {
    
    private func bindSavedCollectionCell() {
        
        detailCollection.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.savedGameBehavior.bind(to: detailCollection.rx.items(cellIdentifier: "SavedCollectionViewCell", cellType: SavedCollectionViewCell.self)) {
            section, item, cell in
            cell.savedGameName.text = item.name
            cell.savedGameImage.sd_setImage(with: URL(string: item.image))
        }.disposed(by: bag)
        
        detailCollection.rx.modelSelected(SavedGames.self)
            .subscribe{ game in
                
                let main = UIStoryboard(name: "Main", bundle: nil)
                let detailVC = main.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                detailVC.slug = game.name
                self.show(detailVC, sender: self)
                
            }.disposed(by: bag)
    
    }
    
}

