//
//  AppCoordinator.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import UIKit

typealias SaveHandler = (String) -> Void

protocol GarmentListCoordinator: AnyObject {
    
    func showAddGarment(saveHandler: @escaping SaveHandler)
}

protocol AddGarmentCoordinator: AnyObject {
    
    func close()
}

final class AppCoordinator: BaseCoordinator, GarmentListCoordinator, AddGarmentCoordinator {
    
    private let navigationController = UINavigationController()
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showGarmentList(animated: false)
    }
    
    private func showGarmentList(animated: Bool = true) {
        // A better option here is to use a factory for creating view controllers, but it's too much for such a small project without UI testing.
        let listViewController = GarmentListViewController.instantiate()
        let viewModel = DefaultGarmentListViewModel(
            storage: DefaultCoreDataStorage(),
            coordinator: self
        )
        listViewController.viewModel = viewModel
        navigationController.pushViewController(listViewController, animated: animated)
    }
    
    func showAddGarment(saveHandler: @escaping SaveHandler) {
        
        let addGarmentViewController = AddGarmentViewController.instantiate()
        let viewModel = DefaultAddGarmentViewModel(
            saveHandler: saveHandler,
            coordinator: self
        )
        addGarmentViewController.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: addGarmentViewController)
        self.navigationController.present(navigationController, animated: true)
    }
    
    func close() {
        
        if let presentedViewController = navigationController.presentedViewController {
            presentedViewController.dismiss(animated: true)
        } else if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        }
    }
}
