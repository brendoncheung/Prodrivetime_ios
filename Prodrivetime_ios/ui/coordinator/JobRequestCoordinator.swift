//
//  RequestCoordinator.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/23/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class JobRequestCoordinator: Coordinator {
    
    let JOB_REQUEST_TAB_TITLE = "Request"
    let DETAIL_REQUEST_TAB_TITLE = "Detail"
    let IMAGE_NAME = "request_tab"
    let TABBAR_TAG = 2
    
    var childCoordinators = [Coordinator]()
    private var rootController = JobRequestViewController.instantiate()
    private var detailViewController = RequestDetailViewController.instantiate()

    private var user: User?
    private var injector: Injector?
    var navigationController: BaseNavigationViewController
    
    init(navigationController: BaseNavigationViewController) {
        self.navigationController = navigationController
    }
    
    func onStart() {
        pushToJobRequestView()
    }
    
    func pushToJobRequestView() {
        guard let user = user, let injector = injector else { fatalError("email and injector cant be nil") }
        rootController.title = JOB_REQUEST_TAB_TITLE
        injector.inject(requestController: rootController)
        rootController.email = user.email
        rootController.coordinator = self
        rootController.tabBarItem = UITabBarItem(title: JOB_REQUEST_TAB_TITLE, image: UIImage(named: IMAGE_NAME), tag: TABBAR_TAG)
        navigationController.pushViewController(rootController, animated: true)
    }
    
    func pushToDetailView(request: JobRequest, rowSelected: Int) {
        guard let injector = injector else { fatalError("inject cant be nil") }
        injector.inject(detailController: detailViewController)
        detailViewController.request = request
        detailViewController.user = user
        detailViewController.rowSelected = rowSelected
        detailViewController.delegate = rootController
        detailViewController.coordinator = self
        detailViewController.navigationController?.navigationBar.prefersLargeTitles = false
        detailViewController.navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    // called when the load is successfully accpeted
    func popBack() {
        navigationController.popViewController(animated: true)
    }
    
    func bindUser(user: User) {
        self.user = user
    }
    
    func bindInjector(injector: Injector) {
        self.injector = injector
    }
}
