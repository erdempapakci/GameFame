//
//  GameStoreResponse.swift
//  GameFame
//
//  Created by Erdem Papakçı on 10.10.2022.
//

import Foundation

struct GameStoreResponse: Codable {
    let results: [GameStore]
}

struct GameStore: Codable {
    let url: String
}
