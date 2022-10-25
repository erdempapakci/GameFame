//
//  SearchByPageCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 25.10.2022.
//

import UIKit

class SearchByPageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet  var maxWidthConstraint: NSLayoutConstraint!{
        didSet {
            maxWidthConstraint.isActive = false
        }
    }
    var maxWidth: CGFloat? = nil {
            didSet {
                guard let maxWidth = maxWidth else {
                    return
                }
                maxWidthConstraint.isActive = true
                maxWidthConstraint.constant = maxWidth
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                contentView.leftAnchor.constraint(equalTo: leftAnchor),
                contentView.rightAnchor.constraint(equalTo: rightAnchor),
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
        }
}
