//
//  NetworkService.swift
//  GameFame
//
//  Created by Erdem Papakçı on 6.10.2022.
//

import Foundation
import Alamofire
import RxSwift

class NetworkService {
   
    
    var popularsBehavior = PublishSubject<[Game]>()
    var metacriticBehavior = PublishSubject<[Game]>()
    var detailBehavior = PublishSubject<GameDetail>()
    var screenShotBehavior = PublishSubject<[GameScreenshot]>()
    var trailerBehavior = PublishSubject<[GameTrailer]>()
    var genresBehavior = PublishSubject<[Genres]>()
    var platformsBehavior = PublishSubject<[GameStore]>()
    private let bag = DisposeBag()
    
    internal func fetchPopularGames(url:String) {
        AF.request(url, method: .get).responseDecodable(of:GamesResponse.self) { response in
            
            switch response.result {
            case .success(let data):
              
                self.popularsBehavior.onNext(data.results)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    internal func fetchMetacriticGames(url:String) {
        AF.request(url, method: .get).responseDecodable(of:GamesResponse.self) { response in
            
            switch response.result {
            case .success(let data):
              
                self.metacriticBehavior.onNext(data.results)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    internal func fetchGameDetails(gameID: String) {
        guard let url = URL(string: "\(APIConstants.BASE_URL)/games/\(gameID)?key=\(APIConstants.API_KEY)") else { return }
        
        AF.request(url, method: .get).responseDecodable(of:GameDetail.self) { response in
            switch response.result {
            case .success(let detail):
                self.detailBehavior.onNext(detail)
                self.genresBehavior.onNext(detail.genres)
            case .failure(let error):
                print(error)
                
            }
            
        }

    }
    internal func fetchGameScreenShots(gameID: String) {
        guard let url = URL(string: "\(APIConstants.BASE_URL)/games/\(gameID)/screenshots?key=\(APIConstants.API_KEY)") else { return }
        
        AF.request(url, method: .get).responseDecodable(of:GameScreenShotResponse.self) { response in
            switch response.result {
            case .success(let screenshot):
                self.screenShotBehavior.onNext(screenshot.results)
            case .failure(let error):
                print(error)
                
            }
            
        }

    }
    internal func fetchGameTrailers(gameID: String) {
        guard let url = URL(string:
                "\(APIConstants.BASE_URL)/games/\(gameID)/movies?key=\(APIConstants.API_KEY)") else { return }
        
        AF.request(url, method: .get).responseDecodable(of:GameTrailerResponse.self) { response in
            switch response.result {
            case .success(let trailers):
                self.trailerBehavior.onNext(trailers.results)
            case .failure(let error):
                print(error)
                
            }
            
        }

    }
    internal func fetchGameStores(gameID: String) {
        guard let url = URL(string:
                "\(APIConstants.BASE_URL)/games/\(gameID)/stores?key=\(APIConstants.API_KEY)") else { return }
        
        AF.request(url, method: .get).responseDecodable(of:GameStoreResponse.self) { response in
            switch response.result {
            case .success(let stores):
                self.platformsBehavior.onNext(stores.results)
            case .failure(let error):
                print(error)
                
            }
            
        }

    }
   
    
    
}
