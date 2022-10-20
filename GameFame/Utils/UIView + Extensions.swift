//
//  UIView + Extensions.swift
//  GameFame
//
//  Created by Erdem Papakçı on 6.10.2022.
//

import UIKit
import SkeletonView

@IBDesignable

final class CardView : UIView {
   
        var fromColor: UIColor?
        var toColor: UIColor?
        var gradientLayer: CAGradientLayer?
        var viewmodel = SearchViewModel()
        
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        viewmodel.isLoadedDelegate = self
        
    }

    @IBInspectable
        var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
               
            }
            set {
                layer.cornerRadius = newValue
                
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

extension CardView: ShimmerProtocol {
    
    func changeShimmer(isLoaded: Bool) {
        if isLoaded == true {
            print("suan var")
            self.hideSkeleton()
        } else {
            print("suan yokum")
            self.isSkeletonable = true
            self.showGradientSkeleton()
        }
       
    }
    
    
}

