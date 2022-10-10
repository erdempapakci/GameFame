//
//  GameScreenShot.swift
//  GameFame
//
//  Created by Erdem Papakçı on 9.10.2022.
//



import Foundation

struct GameScreenShotResponse: Codable {
    let results: [GameScreenshot]
}

struct GameScreenshot: Codable {
    let image: String
}
