//
//  HomeViewModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation
import RxSwift

final class HomeViewModel: HomeViewModelProtocol {
    
    var popularsBehavior = PublishSubject<[Game]>()
    var metacriticBehavior = PublishSubject<[Game]>()
    var gameNewsBehavior = PublishSubject<[GameNews]>()
    var gamePagesBehavior = PublishSubject<[Game]>()
    
    lazy var network: NetworkServiceProtocol = NetworkService()
    
    func fetchPopularGames() {
        
        network.fetchGames(url: APIConstants.POPULAR_URL) { [weak self] response in
            self?.popularsBehavior.onNext(response)
        }
    }
    
    func fetchMetacriticGames() {
        
        network.fetchGames(url: APIConstants.METACRITIC_URL) { [weak self] response in
            self?.metacriticBehavior.onNext(response)
        }
    }
    
    func fetchNews() {
        
        network.fetchGameNews { [weak self] response in
            
            self?.gameNewsBehavior.onNext(response)
        }
    }
    func fetchGamesWithPage(with page: Int) {
        network.fetchGameWithPage(with: page) { [weak self] response in
            self?.gamePagesBehavior.onNext(response)
        }
        
    }
  
    
    
}
