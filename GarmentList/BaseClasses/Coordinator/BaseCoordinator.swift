//
//  BaseCoordinator.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> Void)?
    
    func start() {
        fatalError("Children should implement `start`.")
    }
}
