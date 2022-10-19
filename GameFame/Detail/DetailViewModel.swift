//
//  DetailViewModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation
import RxCocoa
import RxSwift

class DetailViewModel: DetailViewModelProtocol {

    
    var network: NetworkServiceProtocol = NetworkService()
    
    var detailBehavior = PublishSubject<GameDetail>()
    var screenShotBehavior = PublishSubject<[GameScreenshot]>()
    var trailerBehavior = PublishSubject<[GameTrailer]>()
    var genresBehavior = PublishSubject<[Genres]>()
    var platformsBehavior = PublishSubject<[GameStore]>()
    
    
    
    func fetchDetails(slug: String) {
        changeShimmer()
        network.fetchGameDetails(gameID: slug, url: "\(APIConstants.BASE_URL)/games/\(slug)?key=\(APIConstants.API_KEY)") { [weak self] response in
            
            self?.changeShimmer()
            self?.detailBehavior.onNext(response)
            self?.genresBehavior.onNext(response.genres)
            
        }
    }
  
    
    func fetchGameScreenShots(slug: String) {
        changeShimmer()
        network.fetchGameScreenShots(gameID: slug, url: "\(APIConstants.BASE_URL)/games/\(slug)/screenshots?key=\(APIConstants.API_KEY)") { [weak self] response in
            
            self?.changeShimmer()
            self?.screenShotBehavior.onNext(response)
        }
    }
    
    func fetchGameTrailers(slug: String) {
        changeShimmer()
        network.fetchGameTrailers(gameID: slug, url: "\(APIConstants.BASE_URL)/games/\(slug)/movies?key=\(APIConstants.API_KEY)") { [weak self] response in
            
            self?.changeShimmer()
            self?.trailerBehavior.onNext(response)
            
        }
        
    }
    func fetchGameStores(slug: String) {
        changeShimmer()
        network.fetchGameStores(gameID: slug, url: "\(APIConstants.BASE_URL)/games/\(slug)/stores?key=\(APIConstants.API_KEY)") { response in
            
            self.changeShimmer()
            self.platformsBehavior.onNext(response)
        }
    }
    
    
    
    func changeShimmer() {
        
    }
    
    
    
    
}
