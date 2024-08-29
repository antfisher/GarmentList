//
//  GarmentListViewController.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import UIKit

final class GarmentListViewController: BaseViewController<GarmentListViewModel> {
    
    private enum Section {
        case main
    }
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private lazy var dataSource = UITableViewDiffableDataSource<Section, Garment>(tableView: tableView) { tableView, indexPath, item in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GarmentListItemTableViewCell.reuseIdentifier, for: indexPath) as! GarmentListItemTableViewCell
        cell.configure(with: item)
        return cell
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        
        setupNavigationBar()
        setupSegmentedControl()
    }
    
    private func bindViewModel() {
        
        viewModel.itemsSubject
            .sink { [weak self] items in
                self?.reload(with: items)
            }
            .store(in: &cancellables)
    }
    
    private func setupNavigationBar() {
        
        navigationItem.title = NSLocalizedString("GarmentListScreenTitle", comment: "Title for the nav bar")
        
        let addBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "plus.circle"), target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc
    private func addAction() {
        
        viewModel.showAddItemScreen()
    }
    
    private func setupSegmentedControl() {
        
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: NSLocalizedString("AlphabeticalSortingTitle", comment: "Alpabetical sorting title"), at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: NSLocalizedString("CreationTimeSortingTitle", comment: "Creation date sorting title"), at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(selectedControlAction), for: .valueChanged)
    }
    
    @objc
    private func selectedControlAction(_ sender: UISegmentedControl) {
        
        viewModel.changeSorting(sender.selectedSegmentIndex)
    }
    
    private func reload(with items: [Garment]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Garment>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
