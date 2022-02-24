//
//  ProductsLevel2Fetcher.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

final class ProductsLevel2Fetcher: ProductFetching {
    
    // MARK: - Properties
    private let networkRequest: NetworkRequest
    
    var products: [Product] = []
    
    // MARK: - Init
    init(networkRequest: NetworkRequest) {
        self.networkRequest = networkRequest
    }
    
    // MARK: - Request
    func fetchProducts(completion: @escaping NetworkResultClosure) {
        let request = ProductsLevel2Request()
        networkRequest.request(request) { [weak self] result in
            
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let products):
                strongSelf.products = products
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
}
