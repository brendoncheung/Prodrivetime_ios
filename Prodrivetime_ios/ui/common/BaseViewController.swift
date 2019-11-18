//
//  BaseViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/17/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}



