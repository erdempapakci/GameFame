//
//  GamesResponse.swift
//  GameFame
//
//  Created by Erdem Papakçı on 5.10.2022.
//

import Foundation

struct GamesResponse: Codable {
    let results: [Game]
}

struct Game: Codable {
    let name: String?
    let slug: String
    let background_image: String
    let metacritic: Int?
}
