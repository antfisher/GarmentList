//
//  Coordinator.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import Foundation

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    
    func store(coordinator: Coordinator) {
        
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator) {
        
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
