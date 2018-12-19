//
//  AppDelegate.swift
//  FlutterDemo
//
//  Created by Steven Xie on 2018/12/14.
//  Copyright © 2018 Steven Xie. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant // Only if you have Flutter Plugins.

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    
    // Only if you have Flutter plugins.
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self);
        window.backgroundColor = UIColor.white
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
    
}
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        return true
//    }
//    func applicationWillResignActive(_ application: UIApplication) {
//    }
//    func applicationDidEnterBackground(_ application: UIApplication) {
//    }
//    func applicationWillEnterForeground(_ application: UIApplication) {
//    }
//    func applicationDidBecomeActive(_ application: UIApplication) {
//    }
//    func applicationWillTerminate(_ application: UIApplication) {
//    }
//}

