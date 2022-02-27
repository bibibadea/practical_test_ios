//
//  DataManager.swift
//  PT
//
//  Created by iOS Developer on 2/27/22.
//

import Foundation

final class DataManager {
    
    // MARK: - Properties
    var localRepository: Repository & LocalData
    var remoteRepository: Repository
    
    // MARK: - Init
    init() {
        localRepository = LocalRepository()
        remoteRepository = RemoteRepository()
    }
    
    // MARK: - Methods
    func fetchLevel1Products(completion: @escaping ProductsClosure) {
        var seconds = 0
        
        if let date = UserDefaults.standard.value(forKey: Keys.cacheLevel1StartDate) as? Date {
            seconds = Int(Date().timeIntervalSince(date))
        }
        
        if seconds > 300 {
            localRepository.cachedLevel1Products = []
        }
        
        if localRepository.cachedLevel1Products.isEmpty {
            remoteRepository.fetchLevel1Products { [weak self] products in
                
                UserDefaults.standard.setValue(Date(), forKey: Keys.cacheLevel1StartDate)
                
                self?.localRepository.cachedLevel1Products = products
                completion(products)
            }
        } else {
            completion(localRepository.cachedLevel1Products)
        }
    }
    
    func fetchLevel2Products(completion: @escaping ProductsClosure) {
        var seconds = 0
        
        if let date = UserDefaults.standard.value(forKey: Keys.cacheLevel2StartDate) as? Date {
            seconds = Int(Date().timeIntervalSince(date))
        }
        
        if seconds > 300 {
            localRepository.cachedLevel2Products = []
        }
        
        if localRepository.cachedLevel2Products.isEmpty {
            remoteRepository.fetchLevel2Products { [weak self] products in
                
                UserDefaults.standard.setValue(Date(), forKey: Keys.cacheLevel2StartDate)
                
                self?.localRepository.cachedLevel2Products = products
                completion(products)
            }
        } else {
            completion(localRepository.cachedLevel2Products)
        }
    }
    
    func fetchGrades(completion: @escaping GradesClosure) {
        var seconds = 0
        
        if let date = UserDefaults.standard.value(forKey: Keys.cacheGradesStartDate) as? Date {
            seconds = Int(Date().timeIntervalSince(date))
        }
        
        if seconds > 300 {
            localRepository.cachedGrades = []
        }
        
        if localRepository.cachedGrades.isEmpty {
            remoteRepository.fetchGrades { [weak self] grades in
                
                UserDefaults.standard.setValue(Date(), forKey: Keys.cacheGradesStartDate)
                
                self?.localRepository.cachedGrades = grades
                completion(grades)
            }
        } else {
            completion(localRepository.cachedGrades)
        }
    }
    
    func fetchData(completion: @escaping ProductsAndGradesClosure) {
        remoteRepository.fetchData { [weak self] level1, level2, grades in
            
            self?.localRepository.cachedLevel1Products = level1
            self?.localRepository.cachedLevel2Products = level2
            self?.localRepository.cachedGrades = grades
        }
    }
}
