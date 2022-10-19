//
//  NetworkService.swift
//  GameFame
//
//  Created by Erdem Papakçı on 6.10.2022.
//

import Foundation
import Alamofire


class NetworkService: NetworkServiceProtocol {

    func fetchGames(url:String, completion: @escaping([Game]) -> Void) {
        
        AF.request(url, method: .get).responseDecodable(of:GamesResponse.self) { response in
            
            guard let data = response.value else {return}
            completion(data.results)
        }
    }
    
    func fetchGameDetails(gameID: String, url: String, completion: @escaping(GameDetail) -> Void) {
        
        
        AF.request(url, method: .get).responseDecodable(of:GameDetail.self) { response in
            
            guard let data = response.value else {return}
            completion(data)
        }
    }
    
    func fetchGameScreenShots(gameID: String, url: String, completion: @escaping([GameScreenshot]) -> Void) {
        
        AF.request(url, method: .get).responseDecodable(of:GameScreenShotResponse.self) { response in
            
            guard let data = response.value else {return}
            completion(data.results)
            
        }
    }
    
    func fetchGameTrailers(gameID: String, url: String, completion: @escaping([GameTrailer]) -> Void) {
        
        AF.request(url, method: .get).responseDecodable(of:GameTrailerResponse.self) { response in
            
            guard let data = response.value else {return}
            completion(data.results)
        }
    }
    
    func fetchGameStores(gameID: String, url: String, completion: @escaping([GameStore]) -> Void) {
        
        AF.request(url, method: .get).responseDecodable(of:GameStoreResponse.self) { response in
            
            guard let data = response.value else {return}
            completion(data.results)
            
        }
    }
    
    func fetchGameNews(completion: @escaping([GameNews]) -> Void) {
        
        let headers = [
            "X-RapidAPI-Key": "75f022546bmsh2ab473fa3a242e1p132949jsn7bc42c64069c",
            "X-RapidAPI-Host": "videogames-news2.p.rapidapi.com"
        ]
        var request = URLRequest(url: URL(string: "https://videogames-news2.p.rapidapi.com/videogames_news/recent")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        AF.request(request).responseDecodable(of:[GameNews].self) { response in
            guard let data = response.value else {return}
            completion(data)
        }
    }
    
    
    func fetchGameWithSearch(with query: String, completion: @escaping([Game]) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(APIConstants.BASE_URL)/games?key=\(APIConstants.API_KEY)&page_size=20&search=\(query)") else { return }
        
        AF.request(url).responseDecodable(of:GamesResponse.self) { response in
            guard let data = response.value else {return}
            completion(data.results)
        }
    }
    
    
    /*
    func fetchGameWithSearch(with query: String) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(APIConstants.BASE_URL)/games?key=\(APIConstants.API_KEY)&page_size=20&search=\(query)") else { return }
        
        AF.request(url, method: .get).responseDecodable(of:GamesResponse.self) { response in
            switch response.result {
            case .success(let search):
                search.results
                self.gameSearchBehavior.onNext(search.results)
            case .failure(let error):
                print(error)
            }
        }
    }
      */
}

