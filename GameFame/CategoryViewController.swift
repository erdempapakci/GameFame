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
             self.network.fetchPopularGames(url: APIConstants.POPULAR_URL)
             categoryCollectio.rx.setDelegate(self).disposed(by: bag)
             network.popularsBehavior.bind(to: categoryCollectio.rx.items(cellIdentifier: "CategoryCollectionViewCell",cellType: CategoryCollectionViewCell.self)) {
                 section,item,cell in
                 cell.gameName.text = item.name
                 
                 cell.gameImage.sd_setImage(with: URL(string: item.background_image))
                 
             }.disposed(by: bag)
         } else {
             self.network.fetchMetacriticGames(url: APIConstants.METACRITIC_URL)
             categoryCollectio.rx.setDelegate(self).disposed(by: bag)
             network.metacriticBehavior.bind(to: categoryCollectio.rx.items(cellIdentifier: "CategoryCollectionViewCell",cellType: CategoryCollectionViewCell.self)) {
                 section,item,cell in
                 cell.gameName.text = item.name
                 cell.gameImage.sd_setImage(with: URL(string: item.background_image))
                 
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
