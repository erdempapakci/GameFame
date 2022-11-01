//
//  GenresCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 10.10.2022.
//

import UIKit

final class GenresCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var genreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        executeLoading()
    }
    private func executeLoading() {
        genreLabel.startDSLoading()
        
    }
    
    func stopLoading() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2, execute: {
            self.genreLabel.stopDSLoading()
            
        })
        
    }
}
