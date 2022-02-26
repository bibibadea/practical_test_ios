//
//  ProductsListDataSource.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import UIKit

final class ProductsListDataSource: NSObject {
    
    // MARK: - Properties
    private var products: [Product] = []
    private var grades: [Grade] = []
    
    private var isGrade = false
    
    weak var outputProtocol: ProductsListOutputProtocol?
    
    // MARK: - Init
    override init() {
        //
    }
}

// MARK: - TableView
extension ProductsListDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isGrade ? grades.count : products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(withCell: ProductTableViewCell.self, at: indexPath)
        
        if isGrade {
            cell.set(grade: grades[indexPath.row], indexPath: indexPath)
        } else {
            cell.set(product: products[indexPath.row], indexPath: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !isGrade else { return }
        outputProtocol?.selectProduct(product: products[indexPath.row])
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
extension ProductsListDataSource: ProductsListHeaderViewDelegate {
    func select(tab: ProductHeaderTab) {
        outputProtocol?.selectTab(tab: tab)
    }
}

// MARK: - Input Protocol
extension ProductsListDataSource: ProductsListInputProtocol {
    func set(products: [Product]?) {
        self.products = products ?? []
        
        isGrade = false
    }
    
    func set(grades: [Grade]?) {
        self.grades = grades ?? []
        
        isGrade = true
    }
}
