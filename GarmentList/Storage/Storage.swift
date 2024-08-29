//
//  Storage.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import CoreData

protocol Storage {
    
    var persistentContainer: NSPersistentContainer { get }
    
    func addItem(with name: String)
    func getItems(with sortDescriptor: NSSortDescriptor) -> [Garment]
}

private extension Storage {
    
    func saveContext () {
        
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension Storage {
    
    func addItem(with name: String) {
        
        let entitityName = String(describing: Garment.self)
        let entity = NSEntityDescription.entity(forEntityName: entitityName, in: persistentContainer.viewContext)!
        
        let item = Garment(entity: entity, insertInto: persistentContainer.viewContext)
        
        item.id = UUID()
        item.name = name
        item.creationDate = Date()
        
        saveContext()
    }
    
    func getItems(with sortDescriptor: NSSortDescriptor) -> [Garment] {
        
        let fetchRequest = Garment.fetchRequest()

        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // It might be a good idea to handle error instead of using try?
        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
}
