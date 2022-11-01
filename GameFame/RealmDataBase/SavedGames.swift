//
//  RealmModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 21.10.2022.
//
import Foundation
import RealmSwift

class SavedGames: Object {
    
    @Persisted var name : String
    @Persisted var image : String
    
    convenience init(name: String, image:String) {
           self.init()
           self.name = name
           self.image = image
       }
   
}
