//
//  SceneDelegate.swift
//  GameFame
//
//  Created by Erdem Papakçı on 4.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let storyboardName = "Main"
    private let tabbarControllerIdentifier = "TabBarController"
    let vc : OnboardingViewController = OnboardingViewController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        if !UserDefaults.standard.bool(forKey: "didLoadedBefored") {
            UserDefaults.standard.set(true, forKey: "didLoadedBefored")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        } else {
            
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            let tabbarController = storyboard.instantiateViewController(withIdentifier: tabbarControllerIdentifier)
            let navigationController = UINavigationController(rootViewController: tabbarController)
            
            guard let scene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(windowScene: scene)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
            
        }

    }
    
}

