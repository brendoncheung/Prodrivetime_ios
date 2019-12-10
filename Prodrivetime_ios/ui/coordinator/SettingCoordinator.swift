//
//  SettingCoordinator.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class SettingCoordinator: Coordinator {
    
    let TAB_TITLE = "Settings"
    let IMAGE_NAME = "setting_tab"
    let TABBAR_TAG = 5
    let PRIVACY_POLICY_LINK = "https://www.prodrivetime.com/driver/driverRegister"
    let CONTACT_TITLE = "Contact"
    let RATE_US_TITLE = "Rate Us!"
    
    var childCoordinators = [Coordinator]()
    var navigationController: BaseNavigationViewController
    var injector: Injector?
    var user: User?
    
    func onStart() {
        pushToMainSetting()
    }
    
    init(navigationController: BaseNavigationViewController) {
        self.navigationController = navigationController
    }
    
    func pushToMainSetting() {
        let rootController = SettingTableViewController.instantiate()
        injector?.inject(settingController: rootController)
        rootController.title = TAB_TITLE
        rootController.coordinator = self
        rootController.tabBarItem = UITabBarItem(title: TAB_TITLE, image: UIImage(named: IMAGE_NAME), tag: TABBAR_TAG)
        
        navigationController.pushViewController(rootController, animated: true)
    }
    
    func pushToRateUs() {

    }
    
    func pushToContactUs() {
        let contactController = ContactUsTableViewController.instantiate()
        
        contactController.title = CONTACT_TITLE
        navigationController.pushViewController(contactController, animated: true)
    }
    
    func pushToPrivacyPolicy() {
        log.debug("privacy policy")
        guard let url = URL(string: PRIVACY_POLICY_LINK) else { return }
        let svc = SFSafariViewController(url: url)
        navigationController.present(svc, animated: true, completion: nil)
    }
    
    func pushToFeedBack() {
        let supportController = SupportViewController.instantiate()
        let navController = BaseNavigationViewController()
        injector?.inject(supportController: supportController)
        supportController.title = "Feedbacks!"
        supportController.subjectLine = "Feedbacks"
        supportController.user = user
        navController.pushViewController(supportController, animated: true)
        navigationController.present(navController, animated: true, completion: nil)
    }
    
    func pushToLogOut(logoutHandler: @escaping () -> ()) {
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
    
    func bindUser(user: User) {
        self.user = user
    }
    
    
}
