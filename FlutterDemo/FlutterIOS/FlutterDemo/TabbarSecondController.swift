//
//  TabbarSecondController.swift
//  FlutterDemo
//
//  Created by Steven Xie on 2018/12/19.
//  Copyright © 2018 Steven Xie. All rights reserved.
//

import UIKit
import Flutter

class TabbarSecondController: UIViewController {
    
    var _flutterViewController = FlutterViewController()
    
    var eventsBlock: FlutterEventSink?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2)
        containerView.backgroundColor = UIColor.gray
        view.addSubview(containerView)
        
        let channelName = "com.second.your/native_post"
        
        _flutterViewController.setInitialRoute("setting")
        
        let evenChannal = FlutterEventChannel(name: channelName, binaryMessenger: _flutterViewController)
        evenChannal.setStreamHandler(self)
        
        addChild(_flutterViewController)
        containerView.addSubview(_flutterViewController.view)
        
        _flutterViewController.view.frame = containerView.bounds
        _flutterViewController.didMove(toParent: self)
    }
    
    @IBAction func sendTextToFlutterDelegateAction(_ sender: Any) {
        if (eventsBlock != nil) {
            eventsBlock!("哦呵呵")
        }
    }

}

extension TabbarSecondController: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventsBlock = events
        events("ohh,我是一段来自原生的文字,下面那三个按钮没用的，不用试了")
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
}
