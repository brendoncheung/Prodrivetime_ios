//
//  SettingCoordinator.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class SettingCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationViewController
    
    func onStart() {
        pushToMainSetting()
    }
    
    init(navigationController: BaseNavigationViewController) {
        self.navigationController = navigationController
    }
    
    func pushToMainSetting() {
        let rootController = SettingTableViewController.instantiate()
        rootController.title = "Setting"
        rootController.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(named: "setting_tab"), tag: 4)
        
        navigationController.pushViewController(rootController, animated: true)
    }
    
    func pushToRateUs() {
        
    }
    
    func pushToContactUs() {
        
        
    }
    
    func pushToPrivacyPolicy() {
        
        
    }
    
    func pushToReportAProblem() {
        
        
    }
    
    func pushToSignOut() {
        
        
    }
    
    
    
    
}
