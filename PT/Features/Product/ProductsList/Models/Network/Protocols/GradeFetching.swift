//
//  GradeFetching.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import Foundation

protocol GradeFetching: AnyObject {
    var grade: Grade { set get }

    func fetchGrade()
}
