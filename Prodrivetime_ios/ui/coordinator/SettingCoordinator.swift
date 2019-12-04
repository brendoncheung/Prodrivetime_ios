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
    
    var injector: Injector?
    
    func onStart() {
        pushToMainSetting()
    }
    
    init(navigationController: BaseNavigationViewController) {
        self.navigationController = navigationController
    }
    
    func pushToMainSetting() {
        let rootController = SettingTableViewController.instantiate()
        injector?.inject(settingController: rootController)
        rootController.title = "Setting"
        rootController.coordinator = self
        rootController.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(named: "setting_tab"), tag: 4)
        
        navigationController.pushViewController(rootController, animated: true)
    }
    
    func pushToRateUs() {
        log.debug("rate us")
    }
    
    func pushToContactUs() {
        let contactController = ContactUsTableViewController.instantiate()
        
        contactController.title = "Contact"
        navigationController.pushViewController(contactController, animated: true)
    }
    
    func pushToPrivacyPolicy() {
        log.debug("privacy policy")
    }
    
    func pushToReportAProblem() {
        log.debug("report a problem")
    }
    
    func pushToSignOut(logoutHandler: @escaping () -> ()) {
        log.debug("sign out")
        let actionSheet = UIAlertController(title: "You are about to log out", message: "Are you sure?", preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Logout", style: .destructive) { (_) in
            logoutHandler()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
        actionSheet.addAction(signOutAction)
        actionSheet.addAction(cancelAction)
        
        navigationController.present(actionSheet, animated: true, completion: nil)
    }
    
    func bindInjector(injector: Injector) {
        self.injector = injector
    }
    
    
    
}
