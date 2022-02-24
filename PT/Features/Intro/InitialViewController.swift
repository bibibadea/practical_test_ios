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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //@TODO fetch from cache?
        self.spinner.on()
        delay {
            self.spinner.off()
            self.coordinator?.openProductModule()
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
