//
//  InitialViewController.swift
//  PT
//
//  Created by iOS Developer on 2/23/22.
//

import UIKit

final class InitialViewController: PTViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var spinner: PTSpinner!
    @IBOutlet weak var logo: UIImageView!
    
    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchProducts()
    }
}

// MARK: - UI
extension InitialViewController {
    private func setupUI() {
        view.backgroundColor = .systemBlue
        
        spinner.set(color: .white)
        
        logo.tintColor = .white
    }
}

// MARK: - Request
extension InitialViewController {
    private func fetchProducts() {
        //@TODO api request
        delay {
            self.setNavigationToProductList()
        }
    }
}

// MARK: - Navigation
extension InitialViewController {
    private func setNavigationToProductList() {
        let vc = ProductsListViewController()
        let navigation = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}


