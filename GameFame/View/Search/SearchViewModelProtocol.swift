//
//  SearchViewModelProtocol.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation

protocol SearchViewModelProtocol {
    
    var network: NetworkServiceProtocol {get set}
    func searchGame(with slug: String)

}
