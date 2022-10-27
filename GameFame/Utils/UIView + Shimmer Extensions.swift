//
//  UIView + Shimmer Extensions.swift
//  GameFame
//
//  Created by Erdem Papakçı on 25.10.2022.
//


import UIKit

extension UIView {
    
    func startDSLoading() {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.bounds
        gradient.colors = [UIColor.gray.cgColor, UIColor.lightGray.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.locations = [0.0, 0.25, 0.75, 1.0]
        gradient.drawsAsynchronously = true
        self.layer.insertSublayer(gradient, at: 0)
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 2.0
        gradientChangeAnimation.toValue = [UIColor.gray.cgColor, UIColor.lightGray.cgColor, UIColor.white.cgColor]
        gradientChangeAnimation.fromValue = [UIColor.white.cgColor, UIColor.lightGray.cgColor, UIColor.gray.cgColor]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.autoreverses = true
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
        
        self.alpha = 0.5
    }
    
    func stopDSLoading() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
            self.layer.sublayers?.removeAll()
        }
    }
}
