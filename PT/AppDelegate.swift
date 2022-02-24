//
//  AppDelegate.swift
//  PT
//
//  Created by iOS Developer on 2/23/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Root Navigation
        setRootNavigation()
        
        return true
    }
    
    // MARK: - Navigation
    func setRootNavigation() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = InitialViewController()
        vc.window = window
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

