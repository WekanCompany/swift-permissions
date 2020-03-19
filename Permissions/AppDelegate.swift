//
//  AppDelegate.swift
//  Permissions
//
//  Created by Santhosh Kumar on 18/03/20.
//  Copyright © 2020 WeKanCode. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = (mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController)!
        
        navController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}

