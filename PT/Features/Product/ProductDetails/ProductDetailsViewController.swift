//
//  ProductDetailsViewController.swift
//  PT
//
//  Created by iOS Developer on 2/23/22.
//

import UIKit

final class ProductDetailsViewController: PTViewController {

    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var aliasLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var clientsLabel: UILabel!
    
    @IBOutlet private weak var nameValueLabel: UILabel!
    @IBOutlet private weak var aliasValueLabel: UILabel!
    @IBOutlet private weak var releaseDateValueLabel: UILabel!
    @IBOutlet private weak var clientsValueLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = .productDetails
        
        nameLabel.text = .name
        aliasLabel.text = .alias
        releaseDateLabel.text = .releaseDate
        clientsLabel.text = .clients
        
        nameValueLabel.text = " "
        aliasValueLabel.text = " "
        releaseDateValueLabel.text = " "
        clientsValueLabel.text = " "
    }
}
