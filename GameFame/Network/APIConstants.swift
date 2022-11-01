//
//  APIConstants.swift
//  GameFame
//
//  Created by Erdem Papakçı on 6.10.2022.
//

import Foundation

struct APIConstants {
    static let API_KEY = "API_KEY"
    static let BASE_URL = "https://api.rawg.io/api"
    static var date = Date()
    static var nowDate = date.getFormattedDate(format: "yyyy-MM-dd")
   
    static let METACRITIC_URL = "\(BASE_URL)/games?key=\(API_KEY)&dates=2000-01-01,\(nowDate)&ordering=-metacritic&page_size=50"
    static let POPULAR_URL = "\(BASE_URL)/games?key=\(API_KEY)&dates=2022-01-01,\(nowDate)&ordering=-added"
    static let UPCOMING_URL = "\(BASE_URL)/games?key=\(API_KEY)&dates=2022-09-28,\(nowDate)&ordering=-added&page_size=10"
    static let DISCOVER_URL = "\(BASE_URL)/games?key=\(API_KEY)&ordering=-added&page_size=40"
}

