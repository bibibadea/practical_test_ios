//
//  Globals.swift
//  PT
//
//  Created by iOS Developer on 2/23/22.
//

import Foundation
import UIKit

typealias Closure = () -> ()

// MARK: - Delay with Closure
func delay(_ by: Double = 2.0, completion: @escaping Closure) {
    DispatchQueue.main.asyncAfter(deadline: .now() + by) {
        completion()
    }
}

// MARK: - Main Thread
func main(_ completion: @escaping Closure) {
    DispatchQueue.main.async() {
        completion()
    }
}

// MARK: - Class Name
protocol Nameable: AnyObject {
    static var name: String { get }
}

extension Nameable {
    static var name: String {
        return String(describing: self)
    }
}

// MARK: - Present Alert on Top ViewController
func alert(_ error: Error?, completion: @escaping Closure) {
    main {
        let message = error?.localizedDescription ?? "-"
        
        let alert = UIAlertController(title: .error,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: .ok,
                                      style: .default,
                                      handler: { _ in
                                        completion()
                                      }))
        
        topController()?.present(alert, animated: true, completion: {
            completion()
        })
    }
}

