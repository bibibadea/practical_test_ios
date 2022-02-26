//
//  Grade.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

struct Grade: Decodable {
    var id: String
    var countLevel1: String
    var countLevel2: String
    var grade: Int
    
    var name: String = ""
    //var intID: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case id = "productId"
        case countLevel1 = "clientCountLevel1"
        case countLevel2 = "clientCountLevel2"
        case grade
    }
}
