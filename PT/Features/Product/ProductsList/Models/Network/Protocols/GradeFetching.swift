//
//  GradeFetching.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

protocol GradeFetching: AnyObject {
    var grades: [Grade] { set get }

    func fetchGrade(completion: @escaping NetworkResultClosure)
}
