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
    @IBOutlet private weak var logo: UIImageView!
    
    // MARK: - Properties
    var coordinator: AppCoordinator?
    private var networkService = ProductListNetworkService()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //@TODO fetch from cache?
        spinner.on()
        networkService.fetchData { [weak self] in
            self?.spinner.off()
            self?.coordinator?.openProductModule()
            print(self?.networkService.gradeFetcher?.grades.count)
            print(self?.networkService.level1ProductFetcher?.products.count)
            print(self?.networkService.level2ProductFetcher?.products.count)
        }
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
