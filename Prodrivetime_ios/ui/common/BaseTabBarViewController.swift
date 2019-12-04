//
//  BaseTabBarViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/19/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
    
    // This will be injected from ApplicationCoordinator
    var userProfile: User?
    var injector: Injector?
    
    let userProfileCoordinator = UserProfileCoordinator(navigationCoordinator: BaseNavigationViewController())
    let requestCoordinator = JobRequestCoordinator(navigationController: BaseNavigationViewController())
    let requestHistoryCoordinator = JobRequestHistoryCoordinator(navigationController: BaseNavigationViewController())
    let settingCoordinator = SettingCoordinator(navigationController: BaseNavigationViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        configureUserProfileCoordinator()
        configureRequestCoordinator()
        configureRequestHistoryCoordinator()
        configureSettingCoordinator()
        
        viewControllers = [
            userProfileCoordinator.navigationController,
            requestCoordinator.navigationController,
            requestHistoryCoordinator.navigationController,
            settingCoordinator.navigationController
        ]
    }
    
    func configureUserProfileCoordinator() {
        guard let userProfile = userProfile, let injector = injector else { fatalError("User profile cant be nil")}
        userProfileCoordinator.bindUserProfile(userProfile: userProfile)
        userProfileCoordinator.bindInjector(injector: injector)
        userProfileCoordinator.onStart()
    }
    
    func configureRequestCoordinator() {
        guard let userProfile = userProfile, let injector = injector else { fatalError("User profile cant be nil")}
        requestCoordinator.bindUser(user: userProfile)
        requestCoordinator.bindInjector(injector: injector)
        requestCoordinator.onStart()
    }
    
    func configureRequestHistoryCoordinator() {
        guard let userProfile = userProfile, let injector = injector else { fatalError("User profile cant be nil")}
        requestHistoryCoordinator.bindUser(user: userProfile)
        requestHistoryCoordinator.bindInjector(injector: injector)
        requestHistoryCoordinator.onStart()
    }

    func configureSettingCoordinator() {
        
        settingCoordinator.onStart()
    }
    

}
