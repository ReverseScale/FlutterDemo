//
//  PushedController.swift
//  FlutterDemo
//
//  Created by Steven Xie on 2018/12/19.
//  Copyright © 2018 Steven Xie. All rights reserved.
//

import UIKit

class PushedController: UIViewController {
    
    @IBOutlet weak var centerLabel: UILabel!
    var parames: Dictionary<String, Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerLabel.text = "我是被 Flutter push 的 \n参数："
            + (parames?["title"] as? String ?? "")
        
        print(parames ?? "")
    }

}
