//
//  SearchTableViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 13.10.2022.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var RatingView: CardView!
    @IBOutlet weak var favView: UIView!
    
    private let likeButton : LikeButton = {
            let button = LikeButton()
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
            return button
        }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setViewConstraints()
    }
    
    @objc func handleLikeButton() {
        likeButton.flipLikeState()
   
    }
    private  func setViewConstraints() {
              
              
            favView.addSubview(likeButton)
              likeButton.translatesAutoresizingMaskIntoConstraints = false
              likeButton.contentMode = .scaleAspectFill
              likeButton.centerYAnchor.constraint(equalTo: favView.centerYAnchor).isActive = true
              likeButton.centerXAnchor.constraint(equalTo: favView.centerXAnchor).isActive = true
          
          }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        gameImage.layer.cornerRadius = 10
    }
    
}
