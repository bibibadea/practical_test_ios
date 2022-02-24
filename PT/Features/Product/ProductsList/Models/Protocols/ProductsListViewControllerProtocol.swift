//
//  ProductsListViewControllerProtocol.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

protocol ProductsListModelControllerProtocol: AnyObject {
    func tableWasPulled()
}

protocol ProductsListViewControllerProtocol: AnyObject {
    func showLoader(_ show: Bool)
    func alert(_ error: Error?)
    func endRefreshControl()
    func updateUI()
}
