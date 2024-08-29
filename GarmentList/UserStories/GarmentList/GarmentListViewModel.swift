//
//  GarmentListViewModel.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import Foundation
import Combine

protocol GarmentListViewModel {
    
    var itemsSubject: CurrentValueSubject<[Garment], Never> { get }
    
    func changeSorting(_ intValue: Int)
    func showAddItemScreen()
}

final class DefaultGarmentListViewModel: GarmentListViewModel {
    
    // MARK: - Public properties
    
    let itemsSubject = CurrentValueSubject<[Garment], Never>([])
    
    // MARK: - Private properties
    
    private var sorting: Sorting = .alphabetical
    private let storage: Storage
    private weak var coordinator: GarmentListCoordinator?
    
    // MARK: - Lifecycle
    
    init(storage: Storage, coordinator: GarmentListCoordinator) {
        self.storage = storage
        self.coordinator = coordinator
        
        getItems(sorting)
    }
    
    // MARK: - Public methods
    
    func changeSorting(_ intValue: Int) {
        
        guard let sorting = Sorting(rawValue: intValue) else {
            return
        }
        self.sorting = sorting
        getItems(sorting)
    }
    
    func showAddItemScreen() {
        
        coordinator?.showAddGarment { [weak self] name in
            self?.addItem(name: name)
        }
    }
    
    // MARK: - Private methods
    
    private func addItem(name: String) {
        
        storage.addItem(with: name)
        getItems(sorting)
    }
    
    private func getItems(_ sorting: Sorting) {
        
        let sortDescriptor = getSortDescriptor(sorting: sorting)
        let items = storage.getItems(with: sortDescriptor)
        itemsSubject.send(items)
    }
}

// MARK: - SortDescriptor

private extension GarmentListViewModel {
    
    func getSortDescriptor(sorting: Sorting) -> NSSortDescriptor {
        switch sorting {
        case .alphabetical:
            return NSSortDescriptor(key: Garment.nameKey, ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
        case .creationDate:
            return NSSortDescriptor(key: Garment.creationDateKey, ascending: false)
        }
    }
}
