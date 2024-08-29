//
//  AddGarmentViewModel.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import Foundation

protocol AddGarmentViewModel {
    
    func save(name: String)
    func close()
}

final class DefaultAddGarmentViewModel: AddGarmentViewModel {
    
    // MARK: - Private properties
    
    private let saveHandler: SaveHandler
    private weak var coordinator: AddGarmentCoordinator?
    
    // MARK: - Lifecycle
    
    init(saveHandler: @escaping SaveHandler, coordinator: AddGarmentCoordinator) {
        self.saveHandler = saveHandler
        self.coordinator = coordinator
    }
    
    // MARK: - Public methods
    
    func save(name: String) {
        
        guard !name.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty else {
            return
        }
        
        saveHandler(name)
        close()
    }
    
    func close() {
        
        coordinator?.close()
    }
}
