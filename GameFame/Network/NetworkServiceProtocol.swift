//
//  NetworkServiceProtocol.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation

protocol NetworkServiceProtocol{
    
    func fetchGames(url:String, completion: @escaping([Game]) -> Void)
    func fetchGameNews(completion: @escaping([GameNews]) -> Void)
    func fetchGameDetails(gameID: String, url: String, completion: @escaping(GameDetail) -> Void)
    func fetchGameScreenShots(gameID: String, url: String, completion: @escaping([GameScreenshot]) -> Void)
    func fetchGameTrailers(gameID: String, url: String, completion: @escaping(GameTrailer) -> Void)
    func fetchGameStores(gameID: String, url: String, completion: @escaping([GameStore]) -> Void)
    func fetchGameWithSearch(with query: String, completion: @escaping([Game]) -> Void)
    func fetchGameWithPage(with page: Int, completion: @escaping([Game]) -> Void)
    
}
