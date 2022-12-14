//
//  NewsCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 11.10.2022.
//

import UIKit

final class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        executeLoading()
    }
    private func executeLoading() {
        newsImage.startDSLoading()
        
    }
    
     func stopLoading() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2, execute: {
            self.newsImage.stopDSLoading()
            
        })
        
    }
    

}
