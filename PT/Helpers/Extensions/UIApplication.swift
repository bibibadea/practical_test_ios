//
//  UIApplication.swift
//  PT
//
//  Created by iOS Developer on 2/26/22.
//

import UIKit

extension UIApplication {
    
}

func topController() -> UIViewController? {
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

    if let navigation = window?.rootViewController as? UINavigationController {
        return navigation.topViewController
    } else if let initialController = window?.rootViewController as? InitialViewController {
        return initialController
    }
    
    return nil
}
