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
 
     var dataManager : IDataBaseManager = DataBaseManager()
    var savedGameBehavior = BehaviorSubject(value: [SavedGames]())
    
    private var bag = DisposeBag()

    func saveGameToRealm(slug: String, imageUrl:String) {
         
        dataManager.createOrDeleteGame(newGame: SavedGames(name: slug, image: imageUrl))
  
    }
   
    func fetchData() {
        
        let array = dataManager.readGame()
       
        savedGameBehavior.bind { saved in
            saved.onNext(array)
                
        }
    
    }
  

}
