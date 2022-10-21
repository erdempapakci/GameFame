//
//  IDataBaseManager.swift
//  GameFame
//
//  Created by Erdem Papakçı on 21.10.2022.
//
import Foundation

protocol IDataBaseManager {
    
    func saveGame(game:SavedGames)
    func fetchAll() -> [SavedGames]
    
    
}


