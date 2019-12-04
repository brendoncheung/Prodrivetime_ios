//
//  Injector.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/18/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

class Injector {
    
    private let compositionRoot: CompositionRoot
    
    init(compositionRoot: CompositionRoot) {
        self.compositionRoot = compositionRoot
    }
    
    func inject(loginViewController: LoginViewController) {
        let coordinator = compositionRoot.getCoordinator()
        let presenter = compositionRoot.getLoginPresenter(viewMvc: loginViewController, coordinator: coordinator)
        let interactor = compositionRoot.getLoginInteractor(presenter: presenter)
        loginViewController.interactor = interactor
    }
    
    func inject(userProfileController: UserProfileViewController) {
        let userProfilePresenter = compositionRoot.getUserProfilePresenter(viewMvc: userProfileController)
        let userProfileInteractor = compositionRoot.getUserProfileViewInteractor(presenter: userProfilePresenter)
        userProfileController.interactor = userProfileInteractor
    }
    
    func inject(requestController: JobRequestViewController) {
        let presenter = compositionRoot.getJobRequestPresenter(viewMvc: requestController)
        let interactor = compositionRoot.getJobRequestInteractor(presenter: presenter)
        requestController.interactor = interactor
    }
    
    func inject(detailController: RequestDetailViewController) {
        let presenter = compositionRoot.getJobRequestDetailPresenter(viewMvc: detailController)
        let interactor = compositionRoot.getJobRequestDetailInteractor(presenter: presenter)
        detailController.interator = interactor
    }
    
    func inject(historyController: JobRequestHistoryViewController) {
        let presenter = compositionRoot.getJobRequestHistoryPresenter(viewMvc: historyController)
        let interactor = compositionRoot.getJobRequestHistoryInteractor(presenter: presenter)
        historyController.interactor = interactor
    }
    
    func inject(historyDetailController: RequestHistoryDetailViewController) {
        let presenter = compositionRoot.getJobRequestHistoryDetailPresenter(viewMvc: historyDetailController)
        let interactor = compositionRoot.getJobRequestHistoryDetailsInteractor(presenter: presenter)
        historyDetailController.interactor = interactor
    }
    
    func inject(settingController: SettingTableViewController) {
        let presenter = compositionRoot.getSettingPresenter(viewMvc: settingController)
        let interactor = compositionRoot.getSettingInteractor(presenter: presenter)
        settingController.interactor = interactor
    }
    
    
    
    
    
}
