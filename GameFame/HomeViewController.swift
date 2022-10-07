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
    
    @IBOutlet weak var UpComing: UICollectionView!
    @IBOutlet weak var TopRated: UICollectionView!
    @IBOutlet weak var Platforms: UICollectionView!
   
    private var network = NetworkService()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        bindingPopular()
   
    }
   
    private func bindingPopular() {
        self.network.fetchData(url: APIConstants.POPULAR_URL)
        TopRated.rx.setDelegate(self).disposed(by: bag)
        network.detailsBehavior.bind(to: TopRated.rx.items(cellIdentifier: "TopRatedCollectionViewCell",cellType: TopRatedCollectionViewCell.self)) {
            section,item,cell in
            cell.gameName.text = item.name
            cell.gameImage.sd_setImage(with: URL(string: item.background_image))
        }.disposed(by: bag)
       
        
    }
 
    
    
    func registerCells(){
        TopRated.register(UINib(nibName: "TopRatedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCollectionViewCell")
        
    }
    
}



