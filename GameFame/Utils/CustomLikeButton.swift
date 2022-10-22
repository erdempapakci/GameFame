//
//  LikeButton.swift
//  GameFame
//
//  Created by Erdem Papakçı on 17.10.2022.
//

import UIKit
import RealmSwift

final class LikeButton: UIButton {
        
 //   private let dataManager : IDataBaseManager = DataBaseManager()
        lazy var realm = try! Realm()
     
         lazy var isLiked = false
    
        private let unLikeImage = UIImage(systemName: "heart")
        private let likeImage = UIImage(systemName: "heart.fill")
        
        private let transformation = CGAffineTransform(scaleX: 1.5, y: 1.5)
        private var saveModel = SavedViewModel()
    
        override public init(frame: CGRect) {
            super.init(frame: frame)
            self.transform = transformation
            setImage(unLikeImage, for: .normal)
           
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func getImage() {
        if isLiked == false {
            setImage(unLikeImage, for: .normal)
        } else {
            setImage(likeImage, for: .normal)
        }
        }
    
        public func  flipLikeState() {
            isLiked = !isLiked
            animate()
        }
        
        private func animate() {
            if isLiked == false {
                UIView.animate(withDuration: 0.1, animations: {
                    let newImage = self.unLikeImage
                    self.transform = self.transform.scaledBy(x: 0.1, y: 0.9)
                    self.setImage(newImage, for: .normal)
                
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.transform = self.transformation
                    })
                })
                
            } else {
                UIView.animate(withDuration: 0.1, animations: {
                    let newImage = self.likeImage
                    self.transform = self.transform.scaledBy(x: 0.1, y: 0.9)
                    self.setImage(newImage, for: .normal)
               
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.transform = self.transformation
                    })
                })
            }
            
          
        }
     
    func deleteOrSaveGame(with slugName:String) {
        
        
        
    }
    
    func isContains(with slugName: String) {
  
        let savedGames = realm.objects(SavedGames.self)
       
        for saved in savedGames {
            
            if saved.name == slugName {
                self.isLiked = true
                return
            }
            
        }
        getImage()
    }

}
