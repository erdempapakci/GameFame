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
    let bag = DisposeBag()
    var popularsBehavior = PublishSubject<[Game]>()
    var metacriticBehavior = PublishSubject<[Game]>()
    func fetchPopularGames(url:String) {
        AF.request(url, method: .get).responseDecodable(of:GamesResponse.self) { response in
            
            switch response.result {
            case .success(let data):
              
                self.popularsBehavior.onNext(data.results)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func fetchMetacriticGames(url:String) {
        AF.request(url, method: .get).responseDecodable(of:GamesResponse.self) { response in
            
            switch response.result {
            case .success(let data):
              
                self.metacriticBehavior.onNext(data.results)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
