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
    
    @IBOutlet weak var trailerImage: UIImageView!
    
    
    var trailerLink = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        let video = URL(string: trailerLink)
        let player = AVPlayer(url: video!)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        self.window?.rootViewController?.present(playerVC, animated: true, completion: nil)
            playerVC.player!.play()
            player.volume = 0.5
        
    }
}
