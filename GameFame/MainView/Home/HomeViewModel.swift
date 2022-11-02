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
        
        network.fetchGameDetails(GamesResponse.self, url: APIConstants.POPULAR_URL, gameID: "") {[weak self] result in
            switch result {
            case .success(let response):
                self?.popularsBehavior.onNext(response.results)
            case .failure(_):
                print(NetworkError.emptyData)
            }
        }
        
    }
    
    func fetchMetacriticGames() {
        
        network.fetchGameDetails(GamesResponse.self, url: APIConstants.METACRITIC_URL, gameID: "") {[weak self] result in
            switch result {
            case .success(let response):
                self?.metacriticBehavior.onNext(response.results)
            case .failure(_):
                print(NetworkError.emptyData)
            }
        }
        
    }
    
    func fetchNews() {
        
        network.fetchGameNews(type: [GameNews].self) { [weak self] response in
            switch response {
            case .failure(_):
                print(NetworkError.unknownError)
                
            case .success(let gameNews):
                self?.gameNewsBehavior.onNext(gameNews)
                
            }
        }
        
    }
    
    func fetchGamesWithPage(with page: Int) {
        
        self.maxValue = page
        
        network.fetchGameWithPage([Game].self, with: page) { [weak self ] result in
            switch result {
            case .success(let game):
                self?.items.accept(game)
            case .failure(_):
                print(NetworkError.emptyData)
            }
        }
        
    }
    
    func handlePageOfGames(givenPage: Int) {
        
        network.fetchGameWithPage([Game].self, with: givenPage) { [weak self] result in
            switch result {
            case .success(let game):
                self?.items.accept((self?.items.value ?? [Game]()) + game)
            case .failure(_):
                print(NetworkError.emptyData)
            }
        }
        
        
    }
    
    func fetchUpComingGames() {
        
        
        network.fetchGameDetails(GamesResponse.self, url: APIConstants.UPCOMING_URL, gameID: "") {[weak self] result in
            switch result {
            case .success(let response):
                self?.upcomingBehavior.onNext(response.results)
            case .failure(_):
                print(NetworkError.emptyData)
            }
        }
    }
}

