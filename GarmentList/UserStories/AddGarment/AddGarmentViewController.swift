//
//  AddGarmentViewController.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import UIKit

final class AddGarmentViewController: BaseViewController<AddGarmentViewModel> {
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var inputTitleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        
        setupNavigationBar()
        setupLabel()
    }

    private func setupNavigationBar() {
        
        navigationItem.title = NSLocalizedString("AddItemScreenTitle", comment: "Title for the nav bar")
        
        let saveButtonTitle = NSLocalizedString("SaveButtonTitle", comment: "Title for the save button")
        let saveBarButtonItem = UIBarButtonItem(title: saveButtonTitle, image: nil, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
        
        let closeBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "xmark.circle"), target: self, action: #selector(closeAction))
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
    
    private func setupLabel() {
        
        inputTitleLabel.text = NSLocalizedString("ItemNameInputTitle", comment: "Text for the input title label")
    }
    
    @objc
    private func saveAction() {
        
        viewModel.save(name: inputTextField.text ?? "")
    }
    
    @objc
    private func closeAction() {
        
        viewModel.close()
    }
}
