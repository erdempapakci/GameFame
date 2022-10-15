//
//  SearchViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 7.10.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class SearchViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    private let network = NetworkService()
    private let bag = DisposeBag()
    
    private var searchValue = BehaviorRelay<String>(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSearchBar()
        registerCell()
        bindTableView()
        modelSelectedTableView()
    }
    
    private func bindTableView() {
        
        searchValue.subscribe { value in
            value.map { keke in
                self.network.fetchGameWithSearch(with: keke)
                
            }
        }
        
        self.network.gameSearchBehavior.bind(to: self.searchTableView.rx.items(cellIdentifier: "SearchTableViewCell",cellType: SearchTableViewCell.self)) {
            section,item,cell in
            
            if item.metacritic == nil {
                cell.RatingView.isHidden = true
                
            }
            
            cell.scoreLabel.text = String(item.metacritic ?? 0)
            cell.gameImage.sd_setImage(with: URL(string: item.background_image))
            cell.gameName.text = item.name
            
        }.disposed(by: self.bag)
   
    }
    
    private func modelSelectedTableView() {
        searchTableView.rx.modelSelected(Game.self)
            .subscribe { game in
                
                let main = UIStoryboard(name: "Main", bundle: nil)
                let detailVC = main.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
           
                print(game.slug)
                
                detailVC.slug = game.slug
                self.show(detailVC, sender: self)
   
            }.disposed(by: bag)
        
    }
    
    private func registerCell() {
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
    }
    
    private func bindSearchBar()  {
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debug()
            .bind(to: searchValue)
            .disposed(by: bag)
    }
}

