//
//  ISavedViewModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 21.10.2022.
//

import Foundation

protocol ISavedViewModel {
    
    var dataManager : IDataBaseManager {get set}
    func fetchData()
    func saveGameToRealm(slug: String, imageUrl:String)
    
}
