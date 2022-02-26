//
//  GradeFetcher.swift
//  PT
//
//  Created by iOS Developer on 2/25/22.
//

import Foundation

final class GradeFetcher: GradeFetching {
    
    // MARK: - Properties
    private let networkRequest: NetworkRequest
    
    var grades: [Grade] = []
    var urlParams: UrlParams = [:]
    
    // MARK: - Init
    init(networkRequest: NetworkRequest) {
        self.networkRequest = networkRequest
    }
    
    // MARK: - Request
    func fetchGrade(completion: @escaping NetworkResultClosure) {
        let request = GradeRequest()
        request.urlQueryParams = urlParams
        networkRequest.request(request) { [weak self] result in
            
            guard let strongSelf = self else { return }

            switch result {
            case .success(let grade):
                strongSelf.grades.append(grade)
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
}
