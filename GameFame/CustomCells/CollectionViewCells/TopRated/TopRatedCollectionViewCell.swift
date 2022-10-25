//
//  TopRatedCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 4.10.2022.
//

import UIKit

final class TopRatedCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        executeLoading()
    }
    
    private func executeLoading() {
        gameImage.startDSLoading()
        gameName.startDSLoading()
    }
    
    func stopLoading() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2, execute: {
            self.gameImage.stopDSLoading()
            self.gameName.stopDSLoading()
        })
        
    }

}
