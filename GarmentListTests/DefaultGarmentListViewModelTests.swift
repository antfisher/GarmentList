//
//  DefaultGarmentListViewModelTests.swift
//  GarmentListTests
//
//  Created by Anton Rybaiev on 14.07.2024.
//

import Foundation

import XCTest
import Combine
@testable import GarmentList

// Obviously, it is not a complete list of tests. For example, I can test sorting after adding a new item: the sorting order should remain the same and the new item should take place according to the sorting order.

final class DefaultGarmentListViewModelTests: XCTestCase {
    
    var storage: InMemoryCoreDataStorage!
    var viewModel: DefaultGarmentListViewModel!
    var coordinator: MockGarmentListCoordinator!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
       
        storage = InMemoryCoreDataStorage()
        coordinator = MockGarmentListCoordinator()
        viewModel = DefaultGarmentListViewModel(storage: storage, coordinator: coordinator)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        
        viewModel = nil
        coordinator = nil
        storage = nil
        cancellables = nil
    }
    
    func testAlphabeticalSorting() throws {
       
        let dressItem = "Dress"
        let shirtItem = "Shirt" 
        let pantItem = "Pant"
        storage.addItem(with: dressItem)
        storage.addItem(with: shirtItem)
        storage.addItem(with: pantItem)
        
        viewModel.changeSorting(Sorting.alphabetical.rawValue)
        
        let expectation = XCTestExpectation(description: "Items should be sorted alpabetically")
        viewModel.itemsSubject
            .sink { items in
                XCTAssertEqual(items.first?.name, dressItem)
                XCTAssertEqual(items.last?.name, shirtItem)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testCreationDateSorting() throws {
        
        let dressItem = "Dress"
        let shirtItem = "Shirt"
        let pantItem = "Pant"
        storage.addItem(with: dressItem)
        storage.addItem(with: shirtItem)
        storage.addItem(with: pantItem)
        
        viewModel.changeSorting(Sorting.creationDate.rawValue)

        let expectation = XCTestExpectation(description: "Items should be sorted by creation date")
        viewModel.itemsSubject
            .sink { items in
                XCTAssertEqual(items.first?.name, pantItem)
                XCTAssertEqual(items.last?.name, dressItem)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testShowAddItemScreen() throws {
        
        let newItemName = "New Garment"
        coordinator.addItemName = newItemName
        viewModel.showAddItemScreen()
        
        let expectation = XCTestExpectation(description: "Items subject should emit new item")
        viewModel.itemsSubject
            .sink { items in
                if items.contains(where: { $0.name == newItemName }) {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
