//
//  SettingPresenter.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol SettingPresenter {
    
}


class SettingPresenterImpl: SettingPresenter {
    
    private weak var viewMvc: SettingTableViewControllerViewMvc?
    
    init(viewMvc: SettingTableViewControllerViewMvc) {
        self.viewMvc = viewMvc
    }
    
    
}
