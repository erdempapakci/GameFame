//
//  SearchViewModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation

import RxSwift

final class SearchViewModel: SearchViewModelProtocol {
 
    private var isLoading = false
    lazy var network: NetworkServiceProtocol = NetworkService()
    var gameSearchBehavior = PublishSubject<[Game]>()
    
    func searchGame(with slug: String) {
        
        network.fetchGameWithSearch(with: slug) {[weak self] response in
            self?.changeShimmer()
            self?.gameSearchBehavior.onNext(response)
            
        }
    }
    func changeShimmer() {
        
    }
    

}
