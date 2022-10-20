//
//  LikeButton.swift
//  GameFame
//
//  Created by Erdem Papakçı on 17.10.2022.
//

import UIKit

final class LikeButton: UIButton {
    
        private var isLiked = false
        
        private let unLikeImage = UIImage(systemName: "heart")
        private let likeImage = UIImage(systemName: "heart.fill")
    private let transformation = CGAffineTransform(scaleX: 1.5, y: 1.5)
        override public init(frame: CGRect) {
            super.init(frame: frame)
            self.transform = transformation
            setImage(unLikeImage, for: .normal)
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public func  flipLikeState() {
            isLiked = !isLiked
            animate()
        }
        
        private func animate() {
            
            UIView.animate(withDuration: 0.1, animations: {
                let newImage = self.isLiked ? self.likeImage : self.unLikeImage
                self.transform = self.transform.scaledBy(x: 0.1, y: 0.9)
                self.setImage(newImage, for: .normal)
                
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = self.transformation
                })
            })
        }
}
