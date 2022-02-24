//
//  ProductFetching.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

protocol ProductFetching: AnyObject {
    var products: [Product] { set get }
    
    func fetchProducts(completion: @escaping NetworkResultClosure)
}
