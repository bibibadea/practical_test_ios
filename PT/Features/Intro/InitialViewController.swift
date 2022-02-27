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
    // replace networkService with Repository
    // private var networkService = ProductListNetworkService()
    
    private var dataManager: DataManager?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dataManager = DataManager()
        
        spinner.on()
        dataManager?.fetchData { [weak self] level1, level2, grades in
            DispatchQueue.main.async {
                self?.spinner.off()
                self?.coordinator?.dataManager = self?.dataManager
                self?.coordinator?.openProductModule()
                
                print(level1.count, level2.count, grades.count)
            }
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
