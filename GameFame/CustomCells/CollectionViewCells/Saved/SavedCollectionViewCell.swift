//
//  SavedCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 21.10.2022.
//

import UIKit

class SavedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var savedGameImage: UIImageView!
    @IBOutlet weak var savedGameName: UILabel!

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    private func executeLoading() {
        savedGameImage.startDSLoading()
        savedGameName.startDSLoading()
    }
    
    func stopLoading() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2, execute: {
            self.savedGameImage.stopDSLoading()
            self.savedGameName.stopDSLoading()
        })
        
    }

}
