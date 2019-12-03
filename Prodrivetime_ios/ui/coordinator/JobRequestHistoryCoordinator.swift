//
//  JobRequestHistoryCoordinator.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/26/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class JobRequestHistoryCoordinator: Coordinator {
    
    let JOB_REQUEST_TAB_TITLE = "History"
    let IMAGE_NAME = "history_tab"
    let TABBAR_TAG = 3
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationViewController
    
    private var user: User?
    private var injector: Injector?
    
    init(navigationController: BaseNavigationViewController) {
        self.navigationController = navigationController
    }
    
    func onStart() {
        pushToMainHistoryList()
    }
    
    func pushToMainHistoryList() {
        
        let rootViewController = JobRequestHistoryViewController.instantiate()
        injector?.inject(historyController: rootViewController)
        rootViewController.title = JOB_REQUEST_TAB_TITLE
        rootViewController.coordinator = self
        rootViewController.user = user
        rootViewController.tabBarItem = UITabBarItem(title: JOB_REQUEST_TAB_TITLE, image: UIImage(named: IMAGE_NAME), tag: TABBAR_TAG)
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToDetailHistory(request: JobRequestHistory) {
        let detailVC = RequestHistoryDetailViewController.instantiate()
        injector?.inject(historyDetailController: detailVC)
        detailVC.title = JOB_REQUEST_TAB_TITLE
        detailVC.request = request
        detailVC.user = user
        navigationController.pushViewController(detailVC, animated: true)
    }

    func bindUser(user: User) {
        self.user = user
    }
    
    func bindInjector(injector: Injector) {
        self.injector = injector
    }
}
