//
//  MockAddGarmentCoordinator.swift
//  GarmentListTests
//
//  Created by Anton Rybaiev on 14.07.2024.
//

import Foundation
@testable import GarmentList

class MockAddGarmentCoordinator: AddGarmentCoordinator {
    var closeCalled = false
    
    func close() {
        closeCalled = true
    }
}
