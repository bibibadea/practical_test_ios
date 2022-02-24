//
//  Coordinatable.swift
//  PT
//
//  Created by iOS Developer on 2/24/22.
//

import UIKit

protocol Coordinatable {
    var navigationController: UINavigationController { get set }
    
    func start()
}
