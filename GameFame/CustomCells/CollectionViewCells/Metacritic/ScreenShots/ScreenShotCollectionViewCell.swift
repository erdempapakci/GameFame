//
//  ScreenShotCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 10.10.2022.
//

import UIKit


final class ScreenShotCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var SSImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        executeLoading()
    }
    private func executeLoading() {
        SSImage.startDSLoading()
        
    }
    
    func stopLoading() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2, execute: {
            self.SSImage.stopDSLoading()
            
        })
        
    }
   
}
