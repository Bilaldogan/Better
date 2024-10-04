//
//  AppDelegate.swift
//  BetBetter
//
//  Created by Bilal on 3.10.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let dependencyManager = DependencyManager()
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        dependencyManager.registerDependencies()
        
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
        return true
    }


}

