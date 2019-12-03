//
//  UserProfileCoordinator.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/25/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class UserProfileCoordinator: Coordinator {
    
    let TAB_TITLE = "Profile"
    let IMAGE_NAME = "userprofile_tab"
    let TABBAR_TAG = 1
    
    var childCoordinators = [Coordinator]()
    var rootController = UserProfileViewController.instantiate()
    
    var navigationController: BaseNavigationViewController
    
    init(navigationCoordinator: BaseNavigationViewController) {
        self.navigationController = navigationCoordinator
    }
    
    var userProfile: User?
    
    func onStart() {
        guard let userProfile = userProfile else { fatalError("user profile cant be nil") }
        
        rootController.tabBarItem = UITabBarItem(title: TAB_TITLE, image: UIImage(named: IMAGE_NAME), tag: TABBAR_TAG)
        rootController.title = "Profile"
        rootController.userProfile = userProfile
        navigationController.pushViewController(rootController, animated: true)
    }
    
    func bindUserProfile(userProfile: User) {
        self.userProfile = userProfile
    }
    
    func bindInjector(injector: Injector) {
        injector.inject(userProfileController: rootController)
    }
    
    private func inject() {
        
    }
    
    
    
    
    
    
    
}
