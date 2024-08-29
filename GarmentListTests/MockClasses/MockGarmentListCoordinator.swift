//
//  MockGarmentListCoordinator.swift
//  GarmentListTests
//
//  Created by Anton Rybaiev on 14.07.2024.
//

import Foundation
@testable import GarmentList

class MockGarmentListCoordinator: GarmentListCoordinator {
    
    var addItemName = ""
    
    func showAddGarment(saveHandler: @escaping SaveHandler) {
        saveHandler(addItemName)
    }
}
