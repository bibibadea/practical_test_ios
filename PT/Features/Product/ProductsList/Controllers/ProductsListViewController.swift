//
//  ProductsListViewController.swift
//  PT
//
//  Created by iOS Developer on 2/23/22.
//

import UIKit

final class ProductsListViewController: PTViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableView_top: NSLayoutConstraint!
    
    @IBOutlet private weak var loaderStackView: UIStackView!
    @IBOutlet private weak var loaderLabel: UILabel!
    @IBOutlet private weak var loaderSpinner: PTSpinner!
    
    // MARK: - Properties
    private var fetchingInProgress = false
    private var level1ProductFetcher: ProductFetching?
    private var level2ProductFetcher: ProductFetching?
    
    private var selectedTab: ProductHeaderTab = .level1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fixRefreshControl()
    }
    
    // MARK: - UI
    private func setupUI() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = .products
        
        // loader
        loaderLabel.text = .fetchingData
        loaderSpinner.set(style: .medium, color: .black)
        loaderSpinner.off()
        
        showLoader(false)
        
        // tableView
        tableView.set(cell: ProductTableViewCell.self)
        tableView.register(header: ProductsListHeaderView.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(tablePulled), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        tableView.reloadData()
    }
    
    private func showLoader(_ show: Bool = true) {
        if show {
            loaderStackView.show()
            loaderSpinner.on()
            
            tableView_top.constant = 60
        } else {
            loaderStackView.hide()
            loaderSpinner.off()
            
            tableView_top.constant = 0
        }
    }
    
    private func fixRefreshControl() {
        if let refresh = tableView.refreshControl {
            if refresh.isRefreshing {
                main { [weak self] in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.tableView.refreshControl?.endRefreshing()
                    strongSelf.showLoader()
                }
            }
        }
    }
    
    private func endRefreshControl() {
        main { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Data
    private func setupData() {
        level1ProductFetcher = ProductsLevel1Fetcher(networkRequest: NetworkRequest())
        level2ProductFetcher = ProductsLevel2Fetcher(networkRequest: NetworkRequest())
    }
}

// MARK: - TableView
extension ProductsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedTab == .level1 {
            return level1ProductFetcher?.products.count ?? 0
        } else if selectedTab == .level2 {
            return level2ProductFetcher?.products.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(withCell: ProductTableViewCell.self, at: indexPath)
        
        var product: Product?
        
        if selectedTab == .level1 {
            product = level1ProductFetcher?.products[indexPath.row]
        } else if selectedTab == .level2 {
            product = level2ProductFetcher?.products[indexPath.row]
        } else {
            
        }
        
        cell.set(product: product, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard selectedTab != .grades else { return }
        
        let vc = ProductDetailsViewController()
        
        if selectedTab == .level1 {
            vc.product = level1ProductFetcher?.products[indexPath.row]
        } else if selectedTab == .level2 {
            vc.product = level2ProductFetcher?.products[indexPath.row]
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeue(withHeader: ProductsListHeaderView.self, at: section)
        
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
}

// MARK: - Header Delegate
extension ProductsListViewController: ProductsListHeaderViewDelegate {
    func select(tab: ProductHeaderTab) {
        selectedTab = tab
        tableView.reloadData()
        
        fetchProducts()
    }
}

// MARK: - Request
extension ProductsListViewController {
    private func fetchProducts(fromRefreshControl: Bool = false) {
        //@TODO check cache 5min before guard
        print(#function, fetchingInProgress, "fromRefreshControl", fromRefreshControl)
        
        guard !fetchingInProgress else { return }
        
        if fromRefreshControl {
            showLoader(false)
        } else {
            endRefreshControl()
            showLoader()
        }
        
        fetchingInProgress = true
        let dispatchGroup = DispatchGroup()
        
        // Fetch Products from Level1
        dispatchGroup.enter()
        level1ProductFetcher?.fetchProducts(completion: { [weak self] success, error in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                dispatchGroup.leave()
                if success {
                    //
                } else {
                    strongSelf.ok(error)
                }
            }
        })
        
        
        // Fetch Products from Level2
        dispatchGroup.enter()
        level2ProductFetcher?.fetchProducts(completion: { [weak self] success, error in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                dispatchGroup.leave()
                if success {
                    //
                } else {
                    strongSelf.ok(error)
                }
            }
        })
        
        //
        dispatchGroup.notify(queue: .main) { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.fetchingInProgress = false
            
            strongSelf.tableView.refreshControl?.endRefreshing()
            strongSelf.showLoader(false)
            
            strongSelf.tableView.reloadData()
        }
    }
    
    @objc private func tablePulled() {
        //@TODO check cache 5min
        guard !fetchingInProgress else {
            
            endRefreshControl()
            return
        }
        
        fetchProducts(fromRefreshControl: true)
    }
}

