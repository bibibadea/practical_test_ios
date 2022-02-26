//
//  ProductTableViewCell.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var boxView: UIView!
    @IBOutlet private weak var boxView_top: NSLayoutConstraint!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Properties
    private var isGrade = false
    
    private var grade: Grade?
    private var product: Product?
    private var indexPath: IndexPath?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        boxView_top.constant = 0
        
        boxView.addBorder(radius: 8, width: 1, color: .black)
        
        titleLabel.text = " "
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        
        
    }
    
    private func updateUI() {
        guard let indexPath = indexPath else { return }
        
        if isGrade {
            guard let grade = grade else { return }
            
            titleLabel.text = grade.name + " - " + "\(grade.grade)"
        } else {
            guard let product = product else { return }
            
            titleLabel.text = product.name
        }
        
        // set top space
        boxView_top.constant = indexPath.row == 0 ? 20 : 0
    }
    
    // MARK: - Set Cell
    func set(product: Product?, indexPath: IndexPath?) {
        self.product = product
        self.indexPath = indexPath
        
        isGrade = false
        updateUI()
    }
    
    func set(grade: Grade?, indexPath: IndexPath?) {
        self.grade = grade
        self.indexPath = indexPath
        
        isGrade = true
        updateUI()
    }
}
