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
    var navigationController: BaseNavigationViewController {set get}
    func onStart()
}

class ApplicationCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: BaseNavigationViewController
    
    private let injector: Injector
    private let window: UIWindow
    
    init(window: UIWindow, navigationController: BaseNavigationViewController,
        injector: Injector) {
        
        self.window = window
        self.navigationController = navigationController
        self.injector = injector
    }
    
    func onStart() {
        let rootController = LoginViewController.instantiate()
        injector.inject(loginViewController: rootController)
        window.rootViewController = rootController
        window.makeKeyAndVisible()
    }
    
    func pushToLoginController() {
        
        
    }
    
    func pushToMainTabBarController(user: User) {
        let tabbarController = BaseTabBarViewController(user: user, injector: injector)
        tabbarController.modalPresentationStyle = .fullScreen
        window.rootViewController?.present(tabbarController, animated: true, completion: nil)
    }
    
}
