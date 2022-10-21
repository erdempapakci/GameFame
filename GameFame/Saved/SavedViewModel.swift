//
//  SavedViewModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 21.10.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class SavedViewModel : ISavedViewModel {
    
   lazy var dataManager : IDataBaseManager = DataBaseManager()
    var savedGameBehavior = PublishSubject<[SavedGames]>()

    private var bag = DisposeBag()

    func saveGameToRealm(slug: String, imageUrl:String) {
                              
         dataManager.saveGame(game: SavedGames(name: slug, image: imageUrl))
  
    }
   
    func fetchData() {
        
        let array = dataManager.fetchAll()

        self.savedGameBehavior.onNext(array)
        
    }

}
