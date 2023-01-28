//
//  SceneDelegate.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 24.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        Appearance.setup()
        
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("Unexpected type of the UIScene.")
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}
