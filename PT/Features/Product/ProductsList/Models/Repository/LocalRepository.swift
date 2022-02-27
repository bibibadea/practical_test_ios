//
//  LocalRepository.swift
//  PT
//
//  Created by iOS Developer on 2/27/22.
//

import Foundation

final class LocalRepository: Repository, LocalData {
    
    // MARK: - Properties
    var cachedLevel1Products: [Product] = []
    var cachedLevel2Products: [Product] = []
    var cachedGrades: [Grade] = []
    
    var level1fetcher: ProductsLevel1Fetcher?
    var level2fetcher: ProductsLevel2Fetcher?
    var gradeFetcher: GradeFetcher?
    
    // MARK: - Init
    init() {
        //
        level1fetcher = ProductsLevel1Fetcher(networkRequest: NetworkRequest())
        level2fetcher = ProductsLevel2Fetcher(networkRequest: NetworkRequest())
        gradeFetcher = GradeFetcher(networkRequest: NetworkRequest())
    }
    
    // MARK: - Methods
    func fetchLevel1Products(completion: @escaping ProductsClosure) {
        // @TODO implement cache
        completion(cachedLevel1Products)
    }
    
    func fetchLevel2Products(completion: @escaping ProductsClosure) {
        // @TODO implement cache
        completion(cachedLevel2Products)
    }
    
    func fetchGrades(completion: @escaping GradesClosure) {
        // @TODO implement cache
        completion(cachedGrades)
    }
    
    func fetchData(completion: @escaping ProductsAndGradesClosure) {
        completion(cachedLevel1Products, cachedLevel2Products, cachedGrades)
    }
    

}
