//
//  Coordinator.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/15/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {set get}
    func onStart()
    func segueToUserProfileVC(user: User)
}

class MainCoordinatorImpl: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private let injector: Injector
    
    init(navigationController: UINavigationController,
        injector: Injector) {
        
        self.navigationController = navigationController
        self.injector = injector
    }
    
    func onStart() {
        let loginController = LoginViewController.instantiate()
        injector.inject(loginViewController: loginController)
        navigationController.pushViewController(loginController, animated: true)
        
    }
    
    func segueToUserProfileVC(user: User) {
        navigationController.pushViewController(UserProfileViewController.instantiate(),
                                                animated: true)
    }
}



