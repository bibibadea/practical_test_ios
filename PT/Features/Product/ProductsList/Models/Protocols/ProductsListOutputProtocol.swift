//
//  ProductsListOutputProtocol.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

protocol ProductsListOutputProtocol: AnyObject {
    func selectProduct(product: Product)
    func selectTab(tab: ProductHeaderTab)
    func reloadUI()
}
