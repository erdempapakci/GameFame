//
//  CategoryViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 11.10.2022.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage
class CategoryViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var categoryCollectio: UICollectionView!
    
    let network = NetworkService()
    let viewModel = HomeViewModel()
    let bag = DisposeBag()
    var slug = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerUI()
        bindingCategory()
    }
    private func registerUI() {
        categoryCollectio.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
}
// DATA BINDING W RX

extension CategoryViewController {
    
    private func bindingCategory() {
        if title == "POPULAR GAMES" {
            
            viewModel.fetchPopularGames()
            categoryCollectio.rx.setDelegate(self).disposed(by: bag)
            viewModel.popularsBehavior.bind(to: categoryCollectio.rx.items(cellIdentifier: "CategoryCollectionViewCell",cellType: CategoryCollectionViewCell.self)) {
                section,item,cell in
                cell.gameName.text = item.name
                
                cell.gameImage.sd_setImage(with: URL(string: item.background_image))
                cell.stopLoading()
            }.disposed(by: bag)
        } else {
            self.viewModel.fetchMetacriticGames()
            categoryCollectio.rx.setDelegate(self).disposed(by: bag)
            viewModel.metacriticBehavior.bind(to: categoryCollectio.rx.items(cellIdentifier: "CategoryCollectionViewCell",cellType: CategoryCollectionViewCell.self)) {
                section,item,cell in
                cell.gameName.text = item.name
                cell.gameImage.sd_setImage(with: URL(string: item.background_image))
                cell.stopLoading()
            }.disposed(by: bag)
        }
        
        categoryCollectio.rx.modelSelected(Game.self)
            .subscribe { game in
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                
                detailVC.slug = game.slug
                self.navigationController?.pushViewController(detailVC, animated: true)
            }.disposed(by: bag)
        
    }
    
}
