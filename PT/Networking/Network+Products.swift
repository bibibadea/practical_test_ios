//
//  Network+Products.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

final class ProductsLevel1Request: DataRequest {
    
    var url: String {
        "http://stage.cp-plan.net/dsa/getProductsLevel1.php"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [Product] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(ProductsList.self, from: data)
        return response.products
    }
}

final class ProductsLevel2Request: DataRequest {
    
    var url: String {
        "http://stage.cp-plan.net/dsa/getProductsLevel2.php"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [Product] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(ProductsList.self, from: data)
        return response.products
    }
}
