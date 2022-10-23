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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let tabbarController = storyboard.instantiateViewController(withIdentifier: tabbarControllerIdentifier)
        let navigationController = UINavigationController(rootViewController: tabbarController)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
     
    }

}

