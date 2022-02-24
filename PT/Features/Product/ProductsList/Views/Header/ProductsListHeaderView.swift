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
    
    @IBOutlet private weak var productsLevel1Button_width: NSLayoutConstraint!
    @IBOutlet private weak var productsLevel2Button_width: NSLayoutConstraint!
    @IBOutlet private weak var gradesButton_width: NSLayoutConstraint!
    
    @IBOutlet private weak var selectedTabView: UIView!
    @IBOutlet private weak var selectedTab_leading: NSLayoutConstraint!
    @IBOutlet private weak var selectedTab_width: NSLayoutConstraint!
    
    @IBOutlet private weak var bottomLineView: UIView!
    
    // MARK: - Properties
    weak var delegate: ProductsListHeaderViewDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - UI
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
        
        setupTabs()
        
        moveView(to: .level2)
        moveView(to: .level1)
    }
    
    private func setupTabs() {
        selectedTab_width.constant = 0
        
        productsLevel1Button_width.constant = 0
        productsLevel2Button_width.constant = 0
        gradesButton_width.constant = 0
        
        let oneTab = UIScreen.main.bounds.width / 3
        let halfTab = oneTab / 2
        
        let fullWidth = oneTab + (halfTab / 2)

        productsLevel1Button_width.constant = fullWidth
        productsLevel2Button_width.constant = fullWidth
        gradesButton_width.constant = halfTab
    }
    
    private func moveView(to tab: ProductHeaderTab) {
        var tabWidth: CGFloat = 0
        var tabLeading: CGFloat = 0
        
        if tab == .level1 {
            tabLeading = 0
            tabWidth = productsLevel1Button.frame.width
        }
        
        if tab == .level2 {
            tabLeading = productsLevel1Button.frame.width
            tabWidth = productsLevel2Button.frame.width
        }
        
        if tab == .grades {
            tabLeading = productsLevel1Button.frame.width + productsLevel2Button.frame.width
            tabWidth = gradesButton.frame.width
        }
        
        selectedTab_width.constant = tabWidth
        selectedTab_leading.constant = tabLeading
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Tab Handler
    @objc private func level1Tapped() {
        moveView(to: .level1)
        
        delegate?.select(tab: .level1)
    }
    
    @objc private func level2Tapped() {
        moveView(to: .level2)
        
        delegate?.select(tab: .level2)
    }
    
    @objc private func gradesTapped() {
        moveView(to: .grades)
        
        delegate?.select(tab: .grades)
    }
}
