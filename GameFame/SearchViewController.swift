//
//  SearchViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 7.10.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class SearchViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    private let bag = DisposeBag()
    private let network = NetworkService()
    fileprivate var tweets = [Game]()
    fileprivate var filteredTweets = [Game]()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
    
    func bindTableView() {
        
        
        searchTableView.rx.setDelegate(self).disposed(by: bag)
        
     
    }
}







