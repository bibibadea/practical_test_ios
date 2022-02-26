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
        return navigation.visibleViewController
    }
    
    return nil
}


//
//extension UIApplication {
//
//    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = viewController as? UINavigationController {
//            return topViewController(nav.visibleViewController)
//        }
//        if let tab = viewController as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return topViewController(selected)
//            }
//        }
//        if let presented = viewController?.presentedViewController {
//            return topViewController(presented)
//        }
//        return viewController
//    }
//}
