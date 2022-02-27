//
//  ProductsListModelController.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

final class ProductsListModelController {
    
    // MARK: - Properties
    var coordinator: ProductCoordinator?
    
    private var fetchingDataInProgress = false
    private var fetchingGradesInProgress = false
    
    private var fetchingProductsInProgress = false
    private var fetchingLevel1InProgress = false
    private var fetchingLevel2InProgress = false
    
    private var selectedTab: ProductHeaderTab = .level1
    
    weak var delegate: ProductsListViewControllerProtocol?
    weak var inputProtocol: ProductsListInputProtocol?
    
    //replace with DataManager
    //private var networkService: ProductListNetworkService?
    var dataManager: DataManager?
    
    // MARK: - Init
    init() {
        // replaced with DataManager
        // networkService = ProductListNetworkService()
    }
    
    // MARK: - Logic
    private func updateData() {
        if selectedTab == .level1 {
            dataManager?.fetchLevel1Products { [weak self] products in
                self?.inputProtocol?.set(products: products)
            }
        }
        
        if selectedTab == .level2 {
            dataManager?.fetchLevel2Products { [weak self] products in
                self?.inputProtocol?.set(products: products)
            }
        }
        
        if selectedTab == .grades {
            dataManager?.fetchGrades { [weak self] grades in
                self?.inputProtocol?.set(grades: grades)
            }
        }
        
        delegate?.updateUI()
    }
    
    // MARK: - Fetch Data
    private func fetchData() {
        guard !fetchingDataInProgress else { return }
        fetchingDataInProgress = true
        
        delegate?.showLoader(true)
        
        dataManager?.fetchGrades { [weak self] grades in
            guard let strongSelf = self else { return }
            
            strongSelf.fetchingDataInProgress = false
            strongSelf.delegate?.endRefreshControl()
            strongSelf.delegate?.showLoader(false)
            
            strongSelf.updateData()
        }
    }
    
    func fetchProductLevel1() {
        guard !fetchingLevel1InProgress else { return }
        fetchingLevel1InProgress = true
        
        delegate?.showLoader(true)
        dataManager?.fetchLevel1Products { [weak self] products in
            guard let strongSelf = self else { return }
            
            strongSelf.fetchingLevel1InProgress = false
            strongSelf.delegate?.endRefreshControl()
            strongSelf.delegate?.showLoader(false)
            
            strongSelf.updateData()
        }
    }
    
    func fetchProductLevel2() {
        guard !fetchingLevel2InProgress else { return }
        fetchingLevel2InProgress = true
        
        delegate?.showLoader(true)
        dataManager?.fetchLevel2Products { [weak self] products in
            guard let strongSelf = self else { return }
            
            strongSelf.fetchingLevel2InProgress = false
            strongSelf.delegate?.endRefreshControl()
            strongSelf.delegate?.showLoader(false)
            
            strongSelf.updateData()
        }
    }
    
    func fetchGrades() {
        fetchData()
    }
}

// MARK: - Pull To Refresh Protocol
extension ProductsListModelController: ProductsListModelControllerProtocol {
    func tableWasPulled() {
        //@TODO check cache 5min
        guard !fetchingDataInProgress else {
            delegate?.endRefreshControl()
            return
        }
        
        fetchData()
    }
}

// MARK: - Output Protocol
extension ProductsListModelController: ProductsListOutputProtocol {
    func selectTab(tab: ProductHeaderTab) {
        selectedTab = tab
        
        if tab == .level1 {
            fetchProductLevel1()
        }
        
        if tab == .level2 {
            fetchProductLevel2()
        }
        
        if tab == .grades {
            fetchGrades()
        }
    }
    
    func selectProduct(product: Product) {
        guard selectedTab != .grades else { return }
        
        coordinator?.showProductDetails(product: product)
    }
    
    func reloadUI() {
        delegate?.updateUI()
    }
}
