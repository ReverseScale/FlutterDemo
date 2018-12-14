//
//  ViewController.swift
//  FlutterDemo
//
//  Created by Steven Xie on 2018/12/14.
//  Copyright © 2018 Steven Xie. All rights reserved.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pushFlutterAction(_ sender: Any) {
        let flutterViewController = FlutterViewController()
//        self.present(flutterViewController, animated: false, completion: nil)
        navigationController?.pushViewController(flutterViewController, animated: true)
    }
    
}

