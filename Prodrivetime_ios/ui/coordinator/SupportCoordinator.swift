//
//  SupportCoordinator.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class SupportCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationViewController
    
    init(navigationController: BaseNavigationViewController) {
        self.navigationController = navigationController
    }
    
    func onStart() {
        
    }
    
    
    
    
    
}
