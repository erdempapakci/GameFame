//
//  HomeViewModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeViewModel: HomeViewModelProtocol {
    var items = BehaviorRelay<[Game]>(value: [])
    var popularsBehavior = PublishSubject<[Game]>()
    var metacriticBehavior = PublishSubject<[Game]>()
    var gameNewsBehavior = PublishSubject<[GameNews]>()
    var gamePagesBehavior = PublishSubject<[Game]>()
    var upcomingBehavior = PublishSubject<[Game]>()
    
    private var maxValue = 1
    
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
        
        self.maxValue = page
        network.fetchGameWithPage(with: page) { [weak self] response in
            self?.items.accept(response)
            
        }
    }
    
    func handlePageOfGames(givenPage: Int) {
        
        network.fetchGameWithPage(with: givenPage) { [weak self] response in
            self?.items.accept((self?.items.value ?? [Game]()) + response)
        }
    }
    
    func fetchUpComingGames() {
        
        network.fetchGames(url: APIConstants.UPCOMING_URL) { [weak self] response in
            self?.upcomingBehavior.onNext(response)
        }
    }
}

