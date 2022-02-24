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
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchProducts()
    }
    
    // MARK: - Methdos
    private func setupUI() {
        navigationItem.title = .products
        
        // tableView
        tableView.set(cell: ProductTableViewCell.self)
        tableView.register(header: ProductsListHeaderView.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        
        tableView.reloadData()
    }
}

// MARK: - TableView
extension ProductsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(withCell: ProductTableViewCell.self, at: indexPath)
        
        cell.set(indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = ProductDetailsViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeue(withHeader: ProductsListHeaderView.self, at: section)
        
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
}

// MARK: - Header Delegate
extension ProductsListViewController: ProductsListHeaderViewDelegate {
    func select(tab: ProductHeaderTab) {
        print(tab)
    }
}



// MARK: - Request
extension ProductsListViewController {
    private func fetchProducts() {
        
    }
}

