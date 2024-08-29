//
//  Storyboarded.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import UIKit

// Not the best option to deal with instantiating view controllers.
// Usually, if i have to deal with storyboards, I prefer using R.swift for it. But this test project is tiny and I don't want to get here unnecessary dependencies.
// When storyboards are not necessary I prefer using SnapKit.

protocol Storyboarded {
    
    static func containingStoryboard() -> Storyboard
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        
        let controller: Self = containingStoryboard().viewController()
        
        return controller
    }
}
