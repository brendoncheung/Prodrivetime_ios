//
//  UserProfileViewCoordinator.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/19/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

class UserProfileViewCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationViewController
    
    private var userProfile: User?
    
    init(navigationController: BaseNavigationViewController) {
        self.navigationController = navigationController
    }
    
    func onStart() {
        let vc = UserProfileViewController.instantiate()
        vc.userProfile = userProfile
        vc.navigationItem.title = "Profile"
        vc.tabBarItem = createTabBarItem()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func bindUserProfile(userProfile: User) {
        self.userProfile = userProfile
    }
    
    private func createTabBarItem() -> UITabBarItem {
        
        let item = UITabBarItem()
        item.title = "Profile"
        item.image = UIImage(named: "userprofile")
        item.tag = 0
        
        return item
    }
}
