//
//  Storyboard.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import UIKit

enum Storyboard: String {
    
    case Main
    
    var instance : UIStoryboard { return UIStoryboard(name: self.rawValue, bundle: Bundle.main) }
    
    func viewController<T: UIViewController>() -> T {
        
        let identifier = String(describing: T.self)
        guard let viewController = self.instance.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Failed to instantiate view controller with identifier \(identifier)")
        }
        return viewController
    }
}
