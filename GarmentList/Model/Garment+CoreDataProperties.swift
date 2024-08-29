//
//  Garment+CoreDataProperties.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//
//

import Foundation
import CoreData


extension Garment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Garment> {
        return NSFetchRequest<Garment>(entityName: "Garment")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var creationDate: Date

}

extension Garment : Identifiable {

}

extension Garment {
    
    static let nameKey = "name"
    static let creationDateKey = "creationDate"
}
