//
//  APIConstants.swift
//  GameFame
//
//  Created by Erdem Papakçı on 6.10.2022.
//

import Foundation

struct APIConstants {
    static let API_KEY = "4ac4470739fb4a86ab7beb437311f517"
    static let BASE_URL = "https://api.rawg.io/api"
    
    static let METACRITIC_URL = "\(BASE_URL)/games?key=\(API_KEY)&dates=2000-01-01,2022-12-31&ordering=-metacritic&page_size=50"
    static let POPULAR_URL = "\(BASE_URL)/games?key=\(API_KEY)&dates=2022-01-01,2022-12-31&ordering=-added"
    static let UPCOMING_URL = "\(BASE_URL)/games?key=\(API_KEY)&dates=2022-08-28,2025-12-31&ordering=-added&page_size=50"
    static let DISCOVER_URL = "\(BASE_URL)/games?key=\(API_KEY)&ordering=-added&page_size=40"
}
