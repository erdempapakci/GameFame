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
    var gameNewsBehavior = PublishSubject<[GameNews]>()
    var gameSearchBehavior = PublishSubject<[Game]>()
    
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
    internal func fetchGameNews() {
       
        let headers = [
            "X-RapidAPI-Key": "75f022546bmsh2ab473fa3a242e1p132949jsn7bc42c64069c",
            "X-RapidAPI-Host": "videogames-news2.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: URL(string: "https://videogames-news2.p.rapidapi.com/videogames_news/recent")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
       
        AF.request(request).responseDecodable(of:[GameNews].self) { response in
            switch response.result {
            case .success(let news):
                self.gameNewsBehavior.onNext(news)
                
            case .failure(let error):
                print(error)
                
            }
            
        }

    }
    
    internal func fetchGameWithSearch(with query: String) {
     
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(APIConstants.BASE_URL)/games?key=\(APIConstants.API_KEY)&page_size=20&search=\(query)") else { return }
        
        AF.request(url, method: .get).responseDecodable(of:GamesResponse.self) { response in
            switch response.result {
            case .success(let search):
                
                self.gameSearchBehavior.onNext(search.results)
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
 
}
