//
//  Repository.swift
//  PT
//
//  Created by iOS Developer on 2/27/22.
//

import Foundation

typealias ProductsClosure = (_ products: [Product]) -> ()
typealias GradesClosure = (_ products: [Grade]) -> ()
typealias ProductsAndGradesClosure = (_ level1: [Product], _ level2: [Product], _ grades: [Grade]) -> ()

protocol Repository {
    func fetchLevel1Products(completion: @escaping ProductsClosure)
    func fetchLevel2Products(completion: @escaping ProductsClosure)
    func fetchGrades(completion: @escaping GradesClosure)
    func fetchData(completion: @escaping ProductsAndGradesClosure)
}

protocol LocalData {
    var cachedLevel1Products: [Product] { get set }
    var cachedLevel2Products: [Product] { get set }
    var cachedGrades: [Grade] { get set }
}
