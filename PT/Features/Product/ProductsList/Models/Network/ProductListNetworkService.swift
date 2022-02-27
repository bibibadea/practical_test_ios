//
//  ProductListNetworkService.swift
//  PT
//
//  Created by iOS Developer on 2/26/22.
//

import Foundation
import UIKit

final class ProductListNetworkService {
    
    // MARK: - Properties
    var level1ProductFetcher: ProductFetching?
    var level2ProductFetcher: ProductFetching?
    var gradeFetcher: GradeFetcher?
    
    // MARK: - Init
    init() {
        level1ProductFetcher = ProductsLevel1Fetcher(networkRequest: NetworkRequest())
        level2ProductFetcher = ProductsLevel2Fetcher(networkRequest: NetworkRequest())
        
        gradeFetcher = GradeFetcher(networkRequest: NetworkRequest())
    }
    
    // MARK: - Fetch Data
    func fetchData(completion: @escaping Closure) {
        let dispatchGroup = DispatchGroup()
        
        // Fetch Products from Level1
        fetchLevel1Products(group: dispatchGroup) { _, _ in }
        
        // Fetch Products from Level2
        fetchLevel2Products(group: dispatchGroup) { _, _ in }
        
        //
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.fetchGrades(completion)
        }
    }
    
    // MARK: - Fetch Level 1&2 Products
    func fetchProducts(completion: @escaping Closure) {
        let dispatchGroup = DispatchGroup()
        
        // Fetch Products from Level1
        fetchLevel1Products(group: dispatchGroup) { _, _ in }
        
        // Fetch Products from Level2
        fetchLevel2Products(group: dispatchGroup) { _, _ in }
        
        //
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    // MARK: - Fetch Level 1 Products
    func fetchLevel1Products(group: DispatchGroup?, completion: @escaping NetworkResultClosure) {
        group?.enter()
        
        level1ProductFetcher?.fetchProducts(completion: { success, error in
            main {
                if success {
                    if group == nil {
                        completion(success, nil)
                    }
                } else {
                    completion(success, error)
                }
                
                group?.leave()
            }
        })
    }
    
    // MARK: - Fetch Level 2 Products
    func fetchLevel2Products(group: DispatchGroup?, completion: @escaping NetworkResultClosure) {
        group?.enter()
        
        level2ProductFetcher?.fetchProducts(completion: { success, error in
            main {
                if success {
                    if group == nil {
                        completion(success, nil)
                    }
                } else {
                    completion(success, error)
                }
                
                group?.leave()
            }
        })
    }
    
    // MARK: - Fetch Grades
    private func fetchGrades(_ completion: @escaping Closure) {
        let queue = DispatchQueue.global(qos: .background)
        
        queue.async { [weak self] in
            guard let strongSelf = self else { return }
            
            var errors: [Error?] = []
            var productsForRequest: [Product] = []
            var requestData: [GradeRequestData] = []
            
            let level1Products: [Product] = strongSelf.level1ProductFetcher?.products ?? []
            let level2Products: [Product] = strongSelf.level2ProductFetcher?.products ?? []
            
            level1Products.forEach { level1 in
                level2Products.forEach { level2 in
                    if level1 == level2 {
                        productsForRequest.append(level1)
                        requestData.append(GradeRequestData(productID: level1.id,
                                                            level1Count: level1.clients.count,
                                                            level2Count: level2.clients.count))
                    }
                }
            }
            
            strongSelf.gradeFetcher?.grades.removeAll()
            
            let dispatchGroup = DispatchGroup()
            
            for data in requestData {
                dispatchGroup.enter()
                strongSelf.gradeFetcher?.urlParams = [
                    "productId" : "\(data.productID)",
                    "clientCountLevel1" : "\(data.level1Count)",
                    "clientCountLevel2" : "\(data.level2Count)",
                ]
                
                strongSelf.gradeFetcher?.fetchGrade(completion: { success, error in
                    if success {
                        //
                    } else {
                        errors.append(error)
                    }
                    dispatchGroup.leave()
                })
            }
            
            let backgroundQueue = DispatchQueue.global(qos: .background)
            dispatchGroup.notify(queue: backgroundQueue) { [weak self] in
                guard let strongSelf = self else { return }
                
                if errors.count > 0 {
                    // @TODO refactor!! this(UIKit) shouldn't be here.
                    let semaphore = DispatchSemaphore(value: 0)
                    var previousAlert: UIAlertController?
                    
                    for (index, error) in errors.enumerated() {
                        let alert = UIAlertController(title: .error + " \(index)", message: error?.localizedDescription ?? "-", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: .ok, style: .default, handler: nil))
                        
                        DispatchQueue.main.async {
                            (previousAlert ?? topController())?.present(alert, animated: true, completion: {
                                    semaphore.signal()
                                    previousAlert = alert
                                }
                            )
                        }//main
                        
                        semaphore.wait()
                    }
                } else {
                    // add product name
                    for product in productsForRequest {
                        if let fetcher = strongSelf.gradeFetcher {
                            for (index, _) in fetcher.grades.enumerated() {
                                if fetcher.grades[index].id == "\(product.id)" {
                                    fetcher.grades[index].name = product.name
                                }
                            }
                        }
                    }
                    
                    // sort grades
                    strongSelf.gradeFetcher?.grades.sort { (Int($0.id) ?? 0) < (Int($1.id) ?? 0) }
                    
                    main {
                        completion()
                    }
                }
            }
        }//queue
    }
}

