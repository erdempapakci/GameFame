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
    var detailsBehavior = PublishSubject<[Game]>()
    func fetchData(url:String) {
        AF.request(url, method: .get).responseDecodable(of:GamesResponse.self) { response in
            
            switch response.result {
            case .success(let data):
              
                self.detailsBehavior.onNext(data.results)
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
