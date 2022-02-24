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
