//
//  UserProfileViewPresenter.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/17/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

protocol UserProfileViewPresenter {
    func displayUserProfile()
    func jobRequestCount(count: Int)
}

class UserProfileViewPresenterImpl: UserProfileViewPresenter {
    
    weak var viewMvc: UserProfileViewMvc?
    
    init(viewMvc: UserProfileViewMvc) {
        self.viewMvc = viewMvc
    }
    
    func displayUserProfile() {
        viewMvc?.populateUI()
    }
    
    func jobRequestCount(count: Int) {
        
        var string = ""
        
         if count == 1 {
            string = "\(count) request"
        } else {
            string = "\(count) requests"
        }
        
        viewMvc?.showJobRequestCount(string: string)
    }
}
