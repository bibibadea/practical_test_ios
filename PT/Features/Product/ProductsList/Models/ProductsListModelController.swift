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
    
    private var fetchingAllRequestsInProgress = false
    
    private var fetchingProductsInProgress = false
    private var fetchingLevel1InProgress = false
    private var fetchingLevel2InProgress = false
    
    private var level1ProductFetcher: ProductFetching?
    private var level2ProductFetcher: ProductFetching?
    
    private var selectedTab: ProductHeaderTab = .level1
    
    weak var delegate: ProductsListViewControllerProtocol?
    weak var inputProtocol: ProductsListInputProtocol?
    
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - Init
    init() {
        level1ProductFetcher = ProductsLevel1Fetcher(networkRequest: NetworkRequest())
        level2ProductFetcher = ProductsLevel2Fetcher(networkRequest: NetworkRequest())
        
        //fetchAllRequests()
        fetchProducts()
    }
    
    // MARK: - Logic
    private func updateData() {
        if selectedTab == .level1 {
            inputProtocol?.set(products: level1ProductFetcher?.products)
        }
        
        if selectedTab == .level2 {
            inputProtocol?.set(products: level2ProductFetcher?.products)
        }
        
        if selectedTab == .grades {
            
        }
        
        delegate?.endRefreshControl()
        delegate?.showLoader(false)
        delegate?.updateUI()
        
        print()
        print("-----------------")
        print("level 1 products:", level1ProductFetcher?.products.count ?? 0)
        print("level 2 products:", level2ProductFetcher?.products.count ?? 0)
        print("grades:", 0)
    }
}

// MARK: - Network Requests
extension ProductsListModelController {
    //
    
    // MARK: - Fetch Level 1&2 Products
    private func fetchProducts() {
        print(#function, fetchingProductsInProgress)
        //@TODO check cache 5min before guard
        guard !fetchingProductsInProgress else { return }
        
        fetchingProductsInProgress = true
        
        // Fetch Products from Level1
        fetchLevel1Products(withDispatch: true)
        
        // Fetch Products from Level2
        fetchLevel2Products(withDispatch: true)
        
        //
        dispatchGroup.notify(queue: .main) { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.fetchingProductsInProgress = false
            
            strongSelf.delegate?.endRefreshControl()
            strongSelf.delegate?.showLoader(false)
            
            strongSelf.updateData()
        }
    }
    
    // MARK: - Fetch Level 1 Products
    private func fetchLevel1Products(withDispatch: Bool) {
        print(#function, fetchingLevel1InProgress)
        guard !fetchingLevel1InProgress else { return }
        
        fetchingLevel1InProgress = true
        
        if withDispatch {
            dispatchGroup.enter()
        }
        
        level1ProductFetcher?.fetchProducts(completion: { [weak self] success, error in
            guard let strongSelf = self else { return }
            
            main {
                if withDispatch {
                    strongSelf.dispatchGroup.leave()
                }
                
                strongSelf.fetchingLevel1InProgress = false
                
                if success {
                    //
                    if !withDispatch {
                        strongSelf.updateData()
                    }
                } else {
                    strongSelf.delegate?.alert(error)
                }
            }
        })
    }
    
    // MARK: - Fetch Level 2 Products
    private func fetchLevel2Products(withDispatch: Bool) {
        print(#function, fetchingLevel2InProgress)
        guard !fetchingLevel2InProgress else { return }
        
        fetchingLevel2InProgress = true
        
        if withDispatch {
            dispatchGroup.enter()
        }
        
        level2ProductFetcher?.fetchProducts(completion: { [weak self] success, error in
            guard let strongSelf = self else { return }
            
            main {
                if withDispatch {
                    strongSelf.dispatchGroup.leave()
                }
                
                strongSelf.fetchingLevel2InProgress = false
                
                if success {
                    //
                    if !withDispatch {
                        strongSelf.updateData()
                    }
                } else {
                    strongSelf.delegate?.alert(error)
                }
            }
        })
    }
    
    // MARK: - Fetch Data
    private func fetchData() {
        print(#function, selectedTab)
        delegate?.showLoader(true)
        
        if selectedTab == .level1 {
            fetchLevel1Products(withDispatch: false)
        }
        
        if selectedTab == .level2 {
            fetchLevel2Products(withDispatch: false)
        }
        
        if selectedTab == .grades {
            
        }
    }
    
    private func fetchAllRequests() {
        print(#function, fetchingAllRequestsInProgress)
        guard !fetchingAllRequestsInProgress else { return }
        
        fetchingAllRequestsInProgress = true
        
        // Fetch Products from Level1
        fetchLevel1Products(withDispatch: true)
        
        // Fetch Products from Level2
        fetchLevel2Products(withDispatch: true)

        //
        dispatchGroup.notify(queue: .main) { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.fetchingAllRequestsInProgress = false
            
            strongSelf.delegate?.endRefreshControl()
            strongSelf.delegate?.showLoader(false)
            
            strongSelf.updateData()
        }
    }
}

// MARK: - Pull To Refresh Protocol
extension ProductsListModelController: ProductsListModelControllerProtocol {
    func tableWasPulled() {
        //@TODO check cache 5min
        guard !fetchingAllRequestsInProgress else {
            delegate?.endRefreshControl()
            return
        }
        
        fetchAllRequests()
    }
}

// MARK: - Output Protocol
extension ProductsListModelController: ProductsListOutputProtocol {
    func selectTab(tab: ProductHeaderTab) {
        selectedTab = tab
        
        fetchData()
    }
    
    func selectProduct(product: Product) {
        guard selectedTab != .grades else { return }
        
        coordinator?.showProductDetails(product: product)
    }
    
    func reloadUI() {
        delegate?.updateUI()
    }
}
