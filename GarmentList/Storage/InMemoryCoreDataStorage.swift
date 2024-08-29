//
//  InMemoryCoreDataStorage.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 14.07.2024.
//

import CoreData

final class InMemoryCoreDataStorage: Storage {
    
    let persistentContainer: NSPersistentContainer
    
    private static let storageName = "GarmentList"
    
    init() {
        
        persistentContainer = NSPersistentContainer(name: Self.storageName)
        
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        persistentContainer.persistentStoreDescriptions = [description]
        
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
