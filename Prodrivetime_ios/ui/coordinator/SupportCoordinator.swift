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
    
    var injector: Injector?
    var user: User?
    
    init(navigationController: BaseNavigationViewController) {
        self.navigationController = navigationController
    }
    
    func onStart() {
        pushToSupportController()
    }
    
    func pushToSupportController() {
        let supportController = SupportViewController.instantiate()
        supportController.title = "Let us help"
        supportController.user = user
        injector?.inject(supportController: supportController)
        navigationController.pushViewController(supportController, animated: true)
    }
    
    func bindInjector(injector: Injector){
        self.injector = injector
    }
    
    func bindUser(user: User){
        self.user = user
    }
    
    
    
    
    
    
}
