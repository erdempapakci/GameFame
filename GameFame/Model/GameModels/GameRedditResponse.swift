//
//  GameRedditResponse.swift
//  GameFame
//
//  Created by Erdem Papakçı on 15.10.2022.
//

import Foundation

struct GameRedditResponse: Codable {

    let results: [GameReddit]
}

struct GameReddit: Codable {
    let name, text: String
    let image: String?
    let url: String
    let username: String

}
