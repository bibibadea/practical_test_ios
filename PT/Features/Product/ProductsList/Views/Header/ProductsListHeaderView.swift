//
//  ProductsListHeaderView.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import UIKit

enum ProductHeaderTab {
    case level1
    case level2
    case grades
}

protocol ProductsListHeaderViewDelegate: AnyObject {
    func select(tab: ProductHeaderTab)
}

final class ProductsListHeaderView: UITableViewHeaderFooterView {

    // MARK: - Outlets
    @IBOutlet private weak var boxView: UIView!
    
    @IBOutlet private weak var productsLevel1Button: UIButton!
    @IBOutlet private weak var productsLevel2Button: UIButton!
    @IBOutlet private weak var gradesButton: UIButton!
    
    @IBOutlet private weak var selectedTabView: UIView!
    @IBOutlet private weak var selectedTab_leading: NSLayoutConstraint!
    @IBOutlet private weak var selectedTab_width: NSLayoutConstraint!
    
    @IBOutlet private weak var bottomLineView: UIView!
    
    // MARK: - Properties
    private var selectedTab: ProductHeaderTab = .level1
    
    weak var delegate: ProductsListHeaderViewDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        bottomLineView.backgroundColor = .black
        
        productsLevel1Button.tintColor = .black
        productsLevel2Button.tintColor = .black
        gradesButton.tintColor = .black
        
        productsLevel1Button.setTitle(.productsLevel1, for: .normal)
        productsLevel2Button.setTitle(.productsLevel2, for: .normal)
        gradesButton.setTitle(.grades, for: .normal)
        
        productsLevel1Button.addTarget(self, action: #selector(level1Tapped), for: .touchUpInside)
        productsLevel2Button.addTarget(self, action: #selector(level2Tapped), for: .touchUpInside)
        gradesButton.addTarget(self, action: #selector(gradesTapped), for: .touchUpInside)
        
        selectedTabView.backgroundColor = .black
        
        moveView(to: selectedTab)
    }
    
    private func moveView(to tab: ProductHeaderTab) {
        var tabWidth: CGFloat = 0
        var tabLeading: CGFloat = 0
        
        switch tab {
        case .level1:
            tabWidth = productsLevel1Button.frame.width
            tabLeading = 0
        case .level2:
            tabWidth = productsLevel2Button.frame.width
            tabLeading = productsLevel2Button.frame.width
        case .grades:
            tabWidth = gradesButton.frame.width
            tabLeading = productsLevel2Button.frame.width * 2
        }
        
        selectedTab_width.constant = tabWidth
        selectedTab_leading.constant = tabLeading
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func level1Tapped() {
        print(#function)
        moveView(to: .level1)
        
        delegate?.select(tab: .level1)
    }
    
    @objc private func level2Tapped() {
        print(#function)
        moveView(to: .level2)
        
        delegate?.select(tab: .level2)
    }
    
    @objc private func gradesTapped() {
        print(#function)
        moveView(to: .grades)
        
        delegate?.select(tab: .grades)
    }
}
