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
    
    func fetchGameDetails<T: Decodable>(_ type:T.Type, url: String, gameID: String, completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        
        AF.request(url, method: .get).responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let decodable):
                completion(.success(decodable))
            case .failure(_):
                completion(.failure(.ErrorDecoding))
            }
            
        }
    }
    
    func fetchGameNews<T: Decodable>(type: T.Type, completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        let headers : HTTPHeaders = [
            "X-RapidAPI-Key": "API_KEY",
            "X-RapidAPI-Host": "videogames-news2.p.rapidapi.com"
        ]
        guard let url = URL(string: "https://videogames-news2.p.rapidapi.com/videogames_news/recent") else {
            print(NetworkError.invalidUrl)
            return
        }
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let decodable):
                completion(.success(decodable))
            case .failure(_):
                completion(.failure(.ErrorDecoding))
            }
            
        }
        
    }
    
    func fetchGameWithPage<T: Decodable>(_ type: T.Type, with page: Int, completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(APIConstants.BASE_URL)/games?key=\(APIConstants.API_KEY)&ordering=-added&page_size=20&page=\(page)") else { return }
        
        AF.request(url).responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let decodable):
                completion(.success(decodable))
            case .failure(_):
                completion(.failure(.ErrorDecoding))
            }
            
        }
        
    }
    
}

