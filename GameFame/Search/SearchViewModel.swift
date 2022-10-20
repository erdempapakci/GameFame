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
    weak var isLoadedDelegate: ShimmerProtocol?
   
    
  
    func searchGame(with slug: String) {
        self.isLoadedDelegate?.changeShimmer(isLoaded: false)
        network.fetchGameWithSearch(with: slug) {[weak self] response in
            self?.isLoadedDelegate?.changeShimmer(isLoaded: false)
            self?.gameSearchBehavior.onNext(response)
            self?.isLoadedDelegate?.changeShimmer(isLoaded: true)
        }
    }

}
protocol ShimmerProtocol: AnyObject {
    
    func changeShimmer(isLoaded: Bool)
    
}
