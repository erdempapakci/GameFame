//
//  NetworkService.swift
//  GameFame
//
//  Created by Erdem Papakçı on 6.10.2022.
//

import Foundation
import Alamofire

final class NetworkService: NetworkServiceProtocol {

    static let sharedInstance = NetworkService()
  
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
    
    func fetchGameTrailers(gameID: String, url: String, completion: @escaping(GameTrailer) -> Void) {
        
        AF.request(url, method: .get).responseDecodable(of:GameTrailerResponse.self) { response in
            
            guard let data = response.value else {return}
            
          
            if data.results.count > 0 {
                completion(data.results.first!)
               
            }
           
            
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
            "X-RapidAPI-Key": "589b522522msh728a92ad97d7a3bp19dfbbjsn77ddf633e1f3",
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
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(APIConstants.BASE_URL)/games?key=\(APIConstants.API_KEY)&page_size=20&search=\(query)") else {return}
        
        AF.request(url).responseDecodable(of:GamesResponse.self) { response in
            guard let data = response.value else {return}
            completion(data.results)
            
           
        }
    }
    
    func fetchGameWithPage(with page: Int, completion: @escaping([Game]) -> Void) {
        
        
        guard let url = URL(string: "\(APIConstants.BASE_URL)/games?key=\(APIConstants.API_KEY)&ordering=-added&page_size=20&page=\(page)") else { return }
       
        
        AF.request(url).responseDecodable(of:GamesResponse.self) { response in
            guard let data = response.value else {return}
            completion(data.results)
   
        }
    }

}

