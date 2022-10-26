//
//  HomeViewModelProtocol.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    var network: NetworkServiceProtocol {get set}
    func fetchPopularGames()
    func fetchMetacriticGames()
    func fetchNews()
    func fetchGamesWithPage(with page: Int)
    
}
