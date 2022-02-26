//
//  PTViewController.swift
//  PT
//
//  Created by iOS Developer on 2/23/22.
//

import UIKit

class PTViewController: UIViewController {
    
    // MARK: - Init
    required init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    deinit {
        print("💥", String(describing: self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
    }
}

// MARK: - General AlertView
extension PTViewController {
    func ok(_ error: Error?) {
        let message = error?.localizedDescription ?? "-"
        
        let alert = UIAlertController(title: .error,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: .ok,
                                      style: .default,
                                      handler: nil))
        
        if let presented = presentedViewController {
            presented.present(alert, animated: true, completion: nil)
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
    
    func ok(_ message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: .ok,
                                      style: .default,
                                      handler: nil))
        
        if let presented = presentedViewController {
            presented.present(alert, animated: true, completion: nil)
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
}
