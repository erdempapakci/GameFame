//
//  OnboardingCollectionViewCell.swift
//  GameFame
//
//  Created by Erdem Papakçı on 27.10.2022.
//

import UIKit
import Lottie

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var maintTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet  var animationView: LottieAnimationView!
  
    var actionButtonDidTap: (() -> Void)?
    
    func configure(with slide: Slide) {
        maintTitleLabel.text = slide.maintitle
        titleLabel.text = slide.title
        actionButton.backgroundColor = slide.buttonColor
        actionButton.setTitle(slide.buttonTitle, for: .normal)
        actionButton.layer.cornerRadius = 10
        animationView.animation = LottieAnimation.named(slide.animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()

    }
 
    @IBAction func actionButtonTapped() {
        actionButtonDidTap?()
        
    }
    
}


