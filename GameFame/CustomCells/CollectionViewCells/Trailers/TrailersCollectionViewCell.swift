//
//  TrailersCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 10.10.2022.
//

import UIKit
import AVFoundation
import AVKit

class TrailersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var trailerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func playButtonClicked(_ sender: Any) {
    }
}
