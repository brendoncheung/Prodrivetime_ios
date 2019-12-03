//
//  MainNavigationViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/18/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationViewController: UINavigationController {
    
    let themeBlue = "0433FF"
    
    override func viewDidLoad() {
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red:0.02, green:0.20, blue:1.00, alpha:1.0)
        ]
    }
}

//        https://hype.codes/how-detect-iphone-x-programmatically
//        navigationBar.barTintColor = UIColor(red:0.02, green:0.20, blue:1.00, alpha:1.0)
