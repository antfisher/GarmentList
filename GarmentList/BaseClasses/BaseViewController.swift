//
//  BaseViewController.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import UIKit
import Combine

class BaseViewController<ViewModel>: UIViewController {
    
    var viewModel: ViewModel {
        get { _viewModel }
        set { _viewModel = newValue }
    }
    
    var _viewModel: ViewModel!
    
    var cancellables = Set<AnyCancellable>()
}

extension BaseViewController: Storyboarded {
    
    static func containingStoryboard() -> Storyboard {
       
        return .Main
    }
}
