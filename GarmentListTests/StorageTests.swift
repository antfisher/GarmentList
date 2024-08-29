//
//  StorageTests.swift
//  GarmentListTests
//
//  Created by Anton Rybaiev on 14.07.2024.
//

import XCTest
import CoreData
@testable import GarmentList

final class StorageTests: XCTestCase {
    
    var storage: Storage!
    
    override func setUpWithError() throws {
        storage = InMemoryCoreDataStorage()
    }
    
    override func tearDownWithError() throws {
        storage = nil
    }
    
    func testAddItem() throws {
        
        let itemName = "Test Garment"
        
        storage.addItem(with: itemName)
        
        let fetchRequest: NSFetchRequest<Garment> = Garment.fetchRequest()
        let items = try storage.persistentContainer.viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.name, itemName)
    }
    
    func testGetItems() throws {
        
        let itemName1 = "Garment 1"
        let itemName2 = "Garment 2"
        storage.addItem(with: itemName1)
        storage.addItem(with: itemName2)
        
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Garment.name), ascending: true)
        
        let items = storage.getItems(with: sortDescriptor)
        
        XCTAssertEqual(items.count, 2)
        XCTAssertEqual(items.first?.name, itemName1)
        XCTAssertEqual(items.last?.name, itemName2)
    }
}
