//
//  UpComingModels.swift
//  GameFame
//
//  Created by Erdem Papakçı on 5.10.2022.
//

import Foundation

struct GamesModel {
   
    let name: String?
        let slug: String
        let background_image: String?
        let description_raw: String?
        let metacritic: Int?
        let rating: Double?
        let ratings: [Rating]
        let genres: [Genres]
        let developers: [Developers]
        let released: String?
        let publishers: [Publishers]
    }

    struct Rating: Codable {
        let id: Int
        let title: String
        let count: Int
        let percent: Double
    }

    struct Genres: Codable {
        let name: String
    }

    struct Developers: Codable {
        let name: String
    }

    struct Publishers: Codable {
        let name: String
    }
