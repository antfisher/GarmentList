//
//  SceneDelegate.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        self.window = window
        
        App.start(window: window)
    }
}
