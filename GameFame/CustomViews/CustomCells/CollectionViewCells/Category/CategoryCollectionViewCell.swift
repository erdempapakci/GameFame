//
//  CategoryCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 11.10.2022.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gameName: UILabel!
    
    @IBOutlet weak var gameImage: UIImageView!
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
