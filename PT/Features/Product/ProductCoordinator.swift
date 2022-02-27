//
//  ProductCoordinator.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import UIKit

final class ProductCoordinator: Coordinatable {
    
    // MARK: - Properties
    var navigationController: UINavigationController
    var dataManager: DataManager?
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Start
    func start() {
        let vc = ProductsListViewController()
        vc.dataManager = dataManager
        vc.coordinator = self
        
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func showProductDetails(product: Product?) {
        let vc = ProductDetailsViewController()
        vc.product = product
        
        navigationController.pushViewController(vc, animated: true)
    }
}
