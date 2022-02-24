//
//  DataRequest.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

typealias NetworkResultClosure = (_ success: Bool, _ error: Error?) -> Void

typealias Headers = [String: String]
typealias UrlParams = [String: String]

protocol DataRequest {
    associatedtype Response
    
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: Headers { get }
    var queryItems: UrlParams { get }
    
    func decode(_ data: Data) throws -> Response
}

// MARK: - Decode
extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
}

// MARK: - Headers + Params
extension DataRequest {
    var headers: Headers {
        [:]
    }
    
    var queryItems: UrlParams {
        [:]
    }
}
