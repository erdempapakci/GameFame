//
//  SearchViewModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation

import RxSwift

final class SearchViewModel: SearchViewModelProtocol {
    
    lazy var network: NetworkServiceProtocol = NetworkService()
    var gameSearchBehavior = PublishSubject<[Game]>()
    
    func searchGame(with slug: String) {
        
        let url = "\(APIConstants.BASE_URL)/games?key=\(APIConstants.API_KEY)&page_size=20&search=\(slug)"
        network.fetchGameDetails(GamesResponse.self, url: url, gameID: slug) { result in
            switch result {
            case .success(let response):
                self.gameSearchBehavior.onNext(response.results)
                
            case .failure(_):
                print(NetworkError.emptyData)
            }
            
        }
    }
    
}
