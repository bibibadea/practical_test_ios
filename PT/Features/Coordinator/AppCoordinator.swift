//
//  AppCoordinator.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import UIKit

final class AppCoordinator: Coordinatable {
    
    // MARK: - Properties
    var window: UIWindow?
    var navigationController: UINavigationController
    var dataManager: DataManager?
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Start
    func start() {
        let vc = InitialViewController()
        vc.coordinator = self
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Product Module
    func openProductModule() {
        let coordinator = ProductCoordinator(navigationController: navigationController)
        coordinator.dataManager = dataManager
        coordinator.start()
        
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
    }
}
