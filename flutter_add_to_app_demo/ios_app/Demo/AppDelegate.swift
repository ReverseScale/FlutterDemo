//
//  AppDelegate.swift
//  Demo
//
//  Created by Yosuke Ishikawa on 2019/08/01.
//  Copyright © 2019 10X, Inc. All rights reserved.
//

import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    let flutterEngine: FlutterEngine = FlutterEngine(name: "io.flutter", project: nil)
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        flutterEngine.run(withEntrypoint: nil)
        
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController.tabBarItem.title = "Home"

        let nativeViewController1 = UIViewController()
        nativeViewController1.navigationItem.title = "Dashboard"
        
        let nativeNavigationController1 = UINavigationController(rootViewController: nativeViewController1)
        nativeNavigationController1.tabBarItem.title = "Dashboard"
        nativeNavigationController1.navigationBar.isTranslucent = false
        
        let nativeViewController2 = UIViewController()
        nativeViewController2.navigationItem.title = "Notifications"
        
        let nativeNavigationController2 = UINavigationController(rootViewController: nativeViewController2)
        nativeNavigationController2.tabBarItem.title = "Notifications"
        nativeNavigationController2.navigationBar.isTranslucent = false
        
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.tabBar.isTranslucent = false
        tabBarController.viewControllers = [flutterViewController, nativeNavigationController1, nativeNavigationController2]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
