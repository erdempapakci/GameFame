//
//  IDataBaseManager.swift
//  GameFame
//
//  Created by Erdem Papakçı on 21.10.2022.
//
import Foundation

protocol IDataBaseManager {
    
   // func createGame(game:SavedGames)
    func readGame() -> [SavedGames]
    func createOrDeleteGame(newGame:SavedGames)
}


