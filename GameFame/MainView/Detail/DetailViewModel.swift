//
//  DetailViewModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift
final class DetailViewModel: DetailViewModelProtocol {
    
    var network: NetworkServiceProtocol = NetworkService()
    var detailBehavior = PublishSubject<GameDetail>()
    var screenShotBehavior = PublishSubject<[GameScreenshot]>()
    var trailerBehavior = PublishSubject<GameTrailerData>()
    var genresBehavior = PublishSubject<[Genres]>()
    var platformsBehavior = PublishSubject<[GameStore]>()
    
    func fetchDetails(slug: String) {
        
        let url = "\(APIConstants.BASE_URL)/games/\(slug)?key=\(APIConstants.API_KEY)"
        network.fetchGameDetails(GameDetail.self, url: url, gameID: slug) { [weak self]result in
            switch result {
            case .success(let detail):
                self?.detailBehavior.onNext(detail)
                self?.genresBehavior.onNext(detail.genres)
            case .failure(_):
                print(NetworkError.emptyData)
            }
        }
        
    }
    
    func fetchGameScreenShots(slug: String) {
        
        let url = "\(APIConstants.BASE_URL)/games/\(slug)/screenshots?key=\(APIConstants.API_KEY)"
        
        network.fetchGameDetails(GameScreenShotResponse.self, url: url, gameID: slug) { [weak self]result in
            switch result {
            case .success(let response):
                self?.screenShotBehavior.onNext(response.results)
            case .failure(_):
                print(NetworkError.emptyData)
            }
        }
        
    }
    
    func fetchGameTrailers(slug: String) {
        
        
        let url = "\(APIConstants.BASE_URL)/games/\(slug)/movies?key=\(APIConstants.API_KEY)"
        
        network.fetchGameDetails(GameTrailerResponse.self, url: url, gameID: slug) {[weak self] result in
            switch result {
            case .success(let response):
                let trailer = response.results
                if trailer.count > 0 {
                    
                    self?.trailerBehavior.onNext((response.results.first?.data)!)
                }
                
            case .failure(_):
                print(NetworkError.emptyData)
            }
        }
    }
    
    func fetchGameStores(slug: String) {
        
        let url = "\(APIConstants.BASE_URL)/games/\(slug)/stores?key=\(APIConstants.API_KEY)"
        network.fetchGameDetails(GameStoreResponse.self, url: url, gameID: slug) { [weak self] result in
            switch result {
            case .success(let response):
                self?.platformsBehavior.onNext(response.results)
            case .failure(_):
                print(NetworkError.emptyData)
            }
            
        }
    }
    
    
    
}
