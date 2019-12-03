//
//  UserProfileViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/17/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

protocol UserProfileViewMvc: class {
    func populateUI()
    func showJobRequestCount(string: String)
}

class UserProfileViewController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var driverIdLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var numberOfRequestLabel: UILabel!
    
    // All dependencies below will be injected by the tabbar controller
    
    var userProfile: User?
    var interactor: UserProfileViewInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.onStart()
        fetchJobRequestCount()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        interactor?.onStop()
    }
    
    func fetchJobRequestCount() {
        guard let email = userProfile?.email else { return }
        interactor?.fetchJobRequestCount(driverEmail: email)
    }
}

extension UserProfileViewController: UserProfileViewMvc {

    func populateUI() {
        
        guard let userProfile = userProfile else {
            fatalError("user profile cant be nil")
        }
        nameLabel.text = userProfile.name!
        emailLabel.text = userProfile.email!
        driverIdLabel.text = userProfile.driverId
        phoneNumberLabel.text = userProfile.phoneNumber!
        cityLabel.text = userProfile.city!
        stateLabel.text = userProfile.state!
        experienceLabel.text = String(userProfile.experience!)
    }
    
    func showJobRequestCount(string: String) {
        numberOfRequestLabel.text = string
    }
}
