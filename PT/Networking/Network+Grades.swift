//
//  Network+Grades.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

final class GradesRequest: NetworkRequest {
    
    var urlQueryParams: UrlParams = [:]
    
    var url: String {
        "http://stage.cp-plan.net/dsa/getGrade.php"
    }
    //getGrade.php?productId=1&clientCountLevel1=4&clientCountLevel2=0
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: UrlParams {
        urlQueryParams
    }
    
    //
    func decode(_ data: Data) throws -> [Grade] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        
        return try decoder.decode([Grade].self, from: data)
    }
}
