//
//  DefaultCoreDataStorage.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 14.07.2024.
//

import CoreData

final class DefaultCoreDataStorage: Storage {
    
    let persistentContainer: NSPersistentContainer
    
    private static let storageName = "GarmentList"
    
    init() {
        
        persistentContainer = NSPersistentContainer(name: Self.storageName)
        
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
