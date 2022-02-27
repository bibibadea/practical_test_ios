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
    
    private var networkService: ProductListNetworkService?
    
    // MARK: - Init
    init() {
        networkService = ProductListNetworkService()
    }
    
    // MARK: - Logic
    private func updateData() {
        if selectedTab == .level1 {
            inputProtocol?.set(products: networkService?.level1ProductFetcher?.products)
        }
        
        if selectedTab == .level2 {
            inputProtocol?.set(products: networkService?.level2ProductFetcher?.products)
        }
        
        if selectedTab == .grades {
            inputProtocol?.set(grades: networkService?.gradeFetcher?.grades)
        }
        
        delegate?.endRefreshControl()
        delegate?.showLoader(false)
        delegate?.updateUI()
        
        print()
        print("-----------------")
        print("level 1 products:", networkService?.level1ProductFetcher?.products.count ?? 0)
        print("level 2 products:", networkService?.level2ProductFetcher?.products.count ?? 0)
        print("grades:", networkService?.gradeFetcher?.grades.count ?? 0)
    }
    
    // MARK: - Fetch Data
    private func fetchData() {
        guard !fetchingDataInProgress else { return }
        fetchingDataInProgress = true
        
        delegate?.showLoader(true)
        networkService?.fetchData() { [weak self] in
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
        networkService?.fetchLevel1Products(group: nil) { [weak self] success, error in
            guard let strongSelf = self else { return }
            
            if success {
                strongSelf.fetchingLevel1InProgress = false
                strongSelf.delegate?.endRefreshControl()
                strongSelf.delegate?.showLoader(false)
                
                strongSelf.updateData()
            } else {
                strongSelf.delegate?.alert(error)
            }
        }
    }
    
    func fetchProductLevel2() {
        guard !fetchingLevel2InProgress else { return }
        fetchingLevel2InProgress = true
        
        delegate?.showLoader(true)
        networkService?.fetchLevel2Products(group: nil) { [weak self] success, error in
            guard let strongSelf = self else { return }
            
            if success {
                strongSelf.fetchingLevel2InProgress = false
                strongSelf.delegate?.endRefreshControl()
                strongSelf.delegate?.showLoader(false)
                
                strongSelf.updateData()
            } else {
                strongSelf.delegate?.alert(error)
            }
        }
    }
    
    func fetchProducts() {
        guard !fetchingProductsInProgress else { return }
        fetchingProductsInProgress = true
        
        delegate?.showLoader(true)
        networkService?.fetchProducts { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.fetchingProductsInProgress = false
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
