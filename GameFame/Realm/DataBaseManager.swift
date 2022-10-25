//
//  DataBaseManager.swift
//  GameFame
//
//  Created by Erdem Papakçı on 21.10.2022.
//

import RealmSwift
import Foundation

class DataBaseManager: IDataBaseManager {
    
    lazy var realm = try! Realm()
    
    func createOrDeleteGame(newGame:SavedGames) {
        
        var savedGames = realm.objects(SavedGames.self)
        let filtered = savedGames.filter("name == %@", newGame.name)
        if filtered.count > 0 {
            do {
                try realm.write({
                    realm.delete(filtered)
                })
            } catch {
                print("error deleting")
            }
            
        } else {
            
            do {
                try realm.write({
                    realm.add(newGame)
                })
            } catch {
                print("error adding")
            }
        }
    }
    
    func readGame() -> [SavedGames] {
        
        return Array(realm.objects(SavedGames.self))
        
    }
    
}

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
