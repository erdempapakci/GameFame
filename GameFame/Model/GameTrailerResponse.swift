//
//  GameTrailer.swift
//  GameFame
//
//  Created by Erdem Papakçı on 10.10.2022.
//

import Foundation

struct GameTrailerResponse: Codable {
    let results: [GameTrailer]
}

struct GameTrailer: Codable {
    let name: String
    let preview: String
    let data: GameTrailerData
}

struct GameTrailerData: Codable {
    let max: String
}
