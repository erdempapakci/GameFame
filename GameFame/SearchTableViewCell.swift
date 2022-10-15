//
//  SearchTableViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 13.10.2022.
//

import UIKit


class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var gameName: UILabel!
 
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
 
    @IBOutlet weak var RatingView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        gameImage.layer.cornerRadius = 10
    }
    
}
