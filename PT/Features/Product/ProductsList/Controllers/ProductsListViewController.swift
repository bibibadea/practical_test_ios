//
//  ProductsListViewController.swift
//  PT
//
//  Created by iOS Developer on 2/23/22.
//

import UIKit

final class ProductsListViewController: PTViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableView_top: NSLayoutConstraint!
    
    @IBOutlet private weak var loaderStackView: UIStackView!
    @IBOutlet private weak var loaderLabel: UILabel!
    @IBOutlet private weak var loaderSpinner: PTSpinner!
    
    // MARK: - Properties
    var coordinator: ProductCoordinator?
    
    private weak var delegate: ProductsListModelControllerProtocol?
    
    private var modelController: ProductsListModelController?
    private var modelDataSource: ProductsListDataSource?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fixRefreshControl()
    }
    
    // MARK: - UI
    private func setupUI() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = .products
        
        // loader
        loaderLabel.text = .fetchingData
        loaderSpinner.set(style: .medium, color: .black)
        loaderSpinner.off()
        
        showLoader(false)
        
        // tableView
        tableView.set(cell: ProductTableViewCell.self)
        tableView.register(header: ProductsListHeaderView.self)
        
        tableView.estimatedRowHeight = 80
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(tablePulled), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        tableView.reloadData()
    }
    
    private func fixRefreshControl() {
        if let refresh = tableView.refreshControl {
            if refresh.isRefreshing {
                main { [weak self] in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.tableView.refreshControl?.endRefreshing()
                    strongSelf.showLoader(true)
                }
            }
        }
    }
    
    // MARK: - Data
    private func setupData() {
        modelController = ProductsListModelController()
        modelController?.delegate = self
        modelController?.coordinator = coordinator
        delegate = modelController
        
        modelDataSource = ProductsListDataSource()
        
        modelDataSource?.outputProtocol = modelController
        modelController?.inputProtocol = modelDataSource
        
        tableView.delegate = modelDataSource
        tableView.dataSource = modelDataSource
        tableView.reloadData()
    }
}

// MARK: - Delegate
extension ProductsListViewController: ProductsListViewControllerProtocol {
    func showLoader(_ show: Bool) {
        if show {
            loaderStackView.show()
            loaderSpinner.on()
            
            tableView_top.constant = 60
        } else {
            loaderStackView.hide()
            loaderSpinner.off()
            
            tableView_top.constant = 0
        }
    }
    
    func endRefreshControl() {
        main { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func alert(_ error: Error?) {
        ok(error)
    }
    
    func updateUI() {
        tableView.reloadData()
    }
}

// MARK: - Pull To Refresh
extension ProductsListViewController {
    @objc private func tablePulled() {
        delegate?.tableWasPulled()
    }
}

