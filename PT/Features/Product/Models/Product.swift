//
//  Product.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

struct ProductsList: Decodable {
    var products: [Product]
}

struct Product: Decodable {
    var id: Int
    var name: String
    var alias: String
    var releaseDate: String
    var clients: [String]
}

extension Product: Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}
