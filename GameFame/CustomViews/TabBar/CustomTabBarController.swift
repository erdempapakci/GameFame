//
//  CustomTabBarController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 7.10.2022.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiddleButton()
    }
    
    private func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 64))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        menuButton.tintColor = .white
        menuButton.backgroundColor = #colorLiteral(red: 0.05769797415, green: 0.1789989769, blue: 0.2456589341, alpha: 1)
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        
        view.addSubview(menuButton)

        menuButton.setImage(UIImage(systemName: "gamecontroller"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 1
    }
    
}




