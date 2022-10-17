//
//  UIView + Extensions.swift
//  GameFame
//
//  Created by Erdem Papakçı on 6.10.2022.
//

import UIKit


@IBDesignable
class CardView : UIView {
    
        var fromColor: UIColor?
        var toColor: UIColor?
        var gradientLayer: CAGradientLayer?
     
        @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
                self.isSkeletonable = true
                self.showAnimatedGradientSkeleton()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.hideSkeleton()
                })
               
            }
        }
        
        @IBInspectable var topColor: UIColor? {
            didSet {
                fromColor = topColor
                setGradient()
            }
        }
        @IBInspectable var bottomColor: UIColor? {
            didSet {
                toColor = bottomColor
                setGradient()
            }
        }
       
        func setGradient() {
            
            let gradientLocations = [0.0,1.0]
            let gradientLayer = CAGradientLayer()
            if fromColor != nil && toColor != nil
            {
                gradientLayer.colors = [fromColor!.cgColor, toColor!.cgColor]
            }
            
            gradientLayer.locations = gradientLocations as [NSNumber]
            
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at: 0)

        }
}



