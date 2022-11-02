//
//  GameNews.swift
//  GameFame
//
//  Created by Erdem Papakçı on 11.10.2022.
//

import Foundation

struct GameNews: Codable {
    let title, date, welcomeDescription: String
    let image: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case title, date
        case welcomeDescription = "description"
        case image, link
    }
}
