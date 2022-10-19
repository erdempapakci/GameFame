//
//  DetailViewModelProtocol.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    var network: NetworkServiceProtocol {get set}
    func fetchDetails(slug: String)
    func fetchGameScreenShots(slug: String)
    func fetchGameTrailers(slug: String)
    func fetchGameStores(slug: String)
    func changeShimmer()
}
