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
       
        network.fetchGameDetails(gameID: slug, url: "\(APIConstants.BASE_URL)/games/\(slug)?key=\(APIConstants.API_KEY)") { [weak self] response in

            self?.detailBehavior.onNext(response)
            self?.genresBehavior.onNext(response.genres)
            
        }
    }
  
    func fetchGameScreenShots(slug: String) {
        
        network.fetchGameScreenShots(gameID: slug, url: "\(APIConstants.BASE_URL)/games/\(slug)/screenshots?key=\(APIConstants.API_KEY)") { [weak self] response in
  
            self?.screenShotBehavior.onNext(response)
        }
    }
    
    func fetchGameTrailers(slug: String) {
        
        network.fetchGameTrailers(gameID: slug, url: "\(APIConstants.BASE_URL)/games/\(slug)/movies?key=\(APIConstants.API_KEY)") { [weak self] response in
    
            self?.trailerBehavior.onNext(response.data)
            
        }
    }

    func fetchGameStores(slug: String) {
      
        network.fetchGameStores(gameID: slug, url: "\(APIConstants.BASE_URL)/games/\(slug)/stores?key=\(APIConstants.API_KEY)") { response in

            self.platformsBehavior.onNext(response)
        }
    }

}
