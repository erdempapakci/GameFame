//
//  HomeViewModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation

import RxSwift
import RxCocoa


final class HomeViewModel: HomeViewModelProtocol {
    
    var popularsBehavior = PublishSubject<[Game]>()
    var metacriticBehavior = PublishSubject<[Game]>()
    var gameNewsBehavior = PublishSubject<[GameNews]>()
    
    private var isLoading = false
    lazy var network: NetworkServiceProtocol = NetworkService()
    
    func fetchPopularGames() {
        
        changeShimmer()
        network.fetchGames(url: APIConstants.POPULAR_URL) { [weak self] response in
            self?.changeShimmer()
            
            self?.popularsBehavior.onNext(response)
            
        }
    }
    
    func fetchMetacriticGames() {
        changeShimmer()
        network.fetchGames(url: APIConstants.METACRITIC_URL) { [weak self] response in
            self?.changeShimmer()
            self?.metacriticBehavior.onNext(response)
            
        }
        
    }
    
    func fetchNews() {
        changeShimmer()
        network.fetchGameNews { [weak self] response in
            self?.changeShimmer()
            self?.gameNewsBehavior.onNext(response)
        }
        
    }
    
   
    
    func changeShimmer() {
        
    }
    
    
    
    
    
}
