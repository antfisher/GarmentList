//
//  App.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import UIKit

struct App {
    
    static var appCoordinator: AppCoordinator!
    
    static func start(window: UIWindow) {
        
        let appCoordinator = AppCoordinator(window: window)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
}
