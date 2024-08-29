//
//  DefaultAddGarmentViewModelTests.swift
//  GarmentListTests
//
//  Created by Anton Rybaiev on 14.07.2024.
//

import XCTest
@testable import GarmentList

final class DefaultAddGarmentViewModelTests: XCTestCase {
    
    var viewModel: DefaultAddGarmentViewModel!
    var mockCoordinator: MockAddGarmentCoordinator!
    var saveHandlerCalled: Bool!
    var savedName: String!

    override func setUpWithError() throws {
        
        mockCoordinator = MockAddGarmentCoordinator()
        saveHandlerCalled = false
        savedName = ""
        viewModel = DefaultAddGarmentViewModel(saveHandler: { name in
            self.saveHandlerCalled = true
            self.savedName = name
        }, coordinator: mockCoordinator)
    }

    override func tearDownWithError() throws {
        
        viewModel = nil
        mockCoordinator = nil
        saveHandlerCalled = nil
        savedName = nil
    }

    func testSaveWithValidName() throws {

        let name = "New Garment"
        
        viewModel.save(name: name)
        
        XCTAssertTrue(saveHandlerCalled, "Save handler should be called")
        XCTAssertEqual(savedName, name, "Saved name should match the input name")
        XCTAssertTrue(mockCoordinator.closeCalled, "Coordinator's close method should be called")
    }

    func testSaveWithInvalidName() throws {

        let emptyName = "    "

        viewModel.save(name: emptyName)
        
        XCTAssertFalse(saveHandlerCalled, "Save handler should not be called for invalid name")
        XCTAssertFalse(mockCoordinator.closeCalled, "Coordinator's close method should not be called for invalid name")
    }

    func testClose() throws {

        viewModel.close()

        XCTAssertTrue(mockCoordinator.closeCalled, "Coordinator's close method should be called")
    }
}
