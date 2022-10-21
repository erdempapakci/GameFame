//
//  DataBaseManager.swift
//  GameFame
//
//  Created by Erdem Papakçı on 21.10.2022.
//

import RealmSwift


class DataBaseManager: IDataBaseManager {
    
    lazy var realm = try! Realm()
    
    func saveGame(game:SavedGames) {
        
        do {
          
            try realm.write({
                realm.add(game)
            })
            
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    func deleteGame(newGame:SavedGames, oldGame: SavedGames ) {
        
        do {
            
            try realm.write({
                if newGame.name == oldGame.name {
                    realm.delete(newGame)
                    realm.delete(oldGame)
                }
            })
        }catch {
            
            print(error.localizedDescription)
        }
        
    }
    
    func fetchAll() -> [SavedGames] {
        
        return Array(realm.objects(SavedGames.self))
        
    }

}
