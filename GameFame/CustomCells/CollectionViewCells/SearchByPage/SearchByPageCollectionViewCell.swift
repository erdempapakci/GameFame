//
//  SearchByPageCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 25.10.2022.
//

import UIKit

class SearchByPageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var gameImage: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
       
        }
    private func executeLoading() {
        titleLabel.startDSLoading()
        gameImage.startDSLoading()
    }
    
    func stopLoading() {
      /*
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2, execute: {
            self.titleLabel.stopDSLoading()
            self.gameImage.stopDSLoading()
        })
       */
    }
}
