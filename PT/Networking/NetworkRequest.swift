//
//  NetworkRequest.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

protocol NetworkRequestProtocol {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

class NetworkRequest: NetworkRequestProtocol {
    func request<Request>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> ()) where Request : DataRequest {
        
        DispatchQueue.global(qos: .background).async {
            //
            guard var urlComponent = URLComponents(string: request.url) else {
                return completion(.failure(NSError(domain: NetworkError.invalidEndpoint, code: 404, userInfo: nil)))
            }
            
            //
            var queryItems: [URLQueryItem] = []
            request.queryItems.forEach {
                let item = URLQueryItem(name: $0.key, value: $0.value)
                queryItems.append(item)
            }
            
            urlComponent.queryItems = queryItems
            
            //
            guard let url = urlComponent.url else {
                return completion(.failure(NSError(domain: NetworkError.invalidEndpoint, code: 404, userInfo: nil)))
            }
            
            //
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            urlRequest.allHTTPHeaderFields = request.headers
            
            //
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                //
                if let error = error {
                    return completion(.failure(error))
                }
                
                //
                guard let response = response as? HTTPURLResponse else {
                    return completion(.failure(NSError(domain: NetworkError.invalidResponse, code: 0, userInfo: nil)))
                }
                
                if !(200..<300).contains(response.statusCode) {
                    return completion(.failure(NSError(domain: NetworkError.requestError, code: response.statusCode, userInfo: nil)))
                }
                
                //
                guard let data = data else {
                    return completion(.failure(NSError(domain: NetworkError.invalidData, code: response.statusCode, userInfo: nil)))
                }
                
                do {
                    try completion(.success(request.decode(data)))
                } catch let error as NSError {
                    completion(.failure(error))
                }
                
            }.resume()
        }
    }
}
