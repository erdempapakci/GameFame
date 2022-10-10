//
//  ViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 4.10.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var metaCritic: UICollectionView!
    @IBOutlet weak var TopRated: UICollectionView!

 
    var slug = String()
    private var network = NetworkService()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        bindingPopular()
        bindingMetaCritic()
    }
   
    private func bindingPopular() {
        self.network.fetchPopularGames(url: APIConstants.POPULAR_URL)
        TopRated.rx.setDelegate(self).disposed(by: bag)
        network.popularsBehavior.bind(to: TopRated.rx.items(cellIdentifier: "TopRatedCollectionViewCell",cellType: TopRatedCollectionViewCell.self)) {
            section,item,cell in
            
            cell.gameName.text = item.name
            cell.gameImage.sd_setImage(with: URL(string: item.background_image))
        }.disposed(by: bag)
     
        TopRated.rx.modelSelected(Game.self)
            .subscribe { game in
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                
                detailVC.slug = game.slug
                self.navigationController?.pushViewController(detailVC, animated: true)
            }.disposed(by: bag)
        
    }
    private func bindingMetaCritic() {
        self.network.fetchMetacriticGames(url: APIConstants.METACRITIC_URL)
        metaCritic.rx.setDelegate(self).disposed(by: bag)
        network.metacriticBehavior.bind(to: metaCritic.rx.items(cellIdentifier: "MetaCriticCollectionViewCell",cellType: MetaCriticCollectionViewCell.self)) {
            section,item,cell in
            
            cell.gameName.text = item.name
            cell.gameImage.sd_setImage(with: URL(string: item.background_image))
        }.disposed(by: bag)
        
    }
    
 
    func registerCells(){
        TopRated.register(UINib(nibName: "TopRatedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCollectionViewCell")
        metaCritic.register(UINib(nibName: "MetaCriticCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MetaCriticCollectionViewCell")
        
    }
    
}



