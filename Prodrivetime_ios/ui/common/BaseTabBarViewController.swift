//
//  BaseTabBarViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/19/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
    
    private let user: User
    private let injector: Injector
    
    let userProfileCoordinator = UserProfileCoordinator(navigationCoordinator: BaseNavigationViewController())
    let requestCoordinator = JobRequestCoordinator(navigationController: BaseNavigationViewController())
    let requestHistoryCoordinator = JobRequestHistoryCoordinator(navigationController: BaseNavigationViewController())
    let settingCoordinator = SettingCoordinator(navigationController: BaseNavigationViewController())
    let supportCoordinator = SupportCoordinator(navigationController: BaseNavigationViewController())
    
    let supportController = SupportViewController.instantiate()
    
    init(user: User, injector: Injector) {
        self.injector = injector
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureTabBarController()
    }
    
    private func configureTabBarController() {
        
        configureUserProfileCoordinator()
        configureRequestCoordinator()
        configureRequestHistoryCoordinator()
        configureSettingCoordinator()
        configureSupportCoordinator()
        
        viewControllers = [
            userProfileCoordinator.navigationController,
            requestCoordinator.navigationController,
            SupportViewController.instantiate(),
            requestHistoryCoordinator.navigationController,
            settingCoordinator.navigationController
        ]
    }
    
    // MARK: coordinator configuration
    
    func configureUserProfileCoordinator() {
        userProfileCoordinator.bindUserProfile(userProfile: user)
        userProfileCoordinator.bindInjector(injector: injector)
        userProfileCoordinator.onStart()
    }
    
    func configureRequestCoordinator() {
        requestCoordinator.bindUser(user: user)
        requestCoordinator.bindInjector(injector: injector)
        requestCoordinator.onStart()
    }
    
    func configureRequestHistoryCoordinator() {
        requestHistoryCoordinator.bindUser(user: user)
        requestHistoryCoordinator.bindInjector(injector: injector)
        requestHistoryCoordinator.onStart()
    }

    func configureSettingCoordinator() {
        settingCoordinator.bindInjector(injector: injector)
        settingCoordinator.onStart()
    }
    
    func configureSupportCoordinator() {
        supportCoordinator.bindInjector(injector: injector)
        supportCoordinator.bindUser(user: user)
        supportCoordinator.onStart()
    }
}

// MARK: - showing modal support controller

extension BaseTabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if #available(iOS 13, *) {
            if viewController is SupportViewController {
                self.modalPresentationStyle = .pageSheet
                self.present(supportCoordinator.navigationController, animated: true, completion: nil)
                return false
            }
        } else {
            return true
        }
        
        return true
            
        
    }
}



