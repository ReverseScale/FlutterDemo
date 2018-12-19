//
//  ViewController.swift
//  FlutterDemo
//
//  Created by Steven Xie on 2018/12/14.
//  Copyright © 2018 Steven Xie. All rights reserved.
//

import UIKit
import Flutter

class TabbarFirstController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pushFlutterBlockAction(_ sender: Any) {
        let flutterViewController = FlutterViewController()
        flutterViewController.hidesBottomBarWhenPushed = true
        flutterViewController.title = "From Native"
        
        let channelName = "com.first.your/native_get"
        let messageChannerl = FlutterMethodChannel(name: channelName, binaryMessenger: flutterViewController)
        messageChannerl.setMethodCallHandler { (call, result) in
            print("flutter 给到我\n方法：\(call.method)\n参数：\(call.arguments ?? "")")
            
            if call.method == "toNativePush" {
                let pushed = PushedController()
                pushed.parames = call.arguments as? Dictionary<String, Any>
                self.navigationController?.pushViewController(pushed, animated: true)
            } else if call.method == "toNativePop" {
                self.navigationController?.popViewController(animated: true)
            } else if call.method == "toShowAlert" {
                self.showAlertView()
            }
        }
        
        navigationController?.pushViewController(flutterViewController, animated: true)
    }
    
    @IBAction func pushFlutterDelegateAction(_ sender: Any) {
        let flutterViewController = FlutterViewController()
        flutterViewController.hidesBottomBarWhenPushed = true
        flutterViewController.title = "From Native"
        
        let channelName = "com.first.your/native_post"
        let evenChannal = FlutterEventChannel(name: channelName, binaryMessenger: flutterViewController)
        evenChannal.setStreamHandler(self)
        
        navigationController?.pushViewController(flutterViewController, animated: true)
    }
    
    
    func showAlertView() {
        let alertController = UIAlertController(title: "我是一个被 Flutter 调用的弹窗", message: "",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in print("好的：我被点击了")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension TabbarFirstController: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        events("我是一段来自原生的文字,下面那三个按钮没用的，不用试了")
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
}
