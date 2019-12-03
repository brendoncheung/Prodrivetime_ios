//
//  ViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

protocol LoginViewMvc: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showAlert(title: String, description: String)
}

class LoginViewController: BaseViewController, Storyboarded {
    
    var interactor: LoginInteractor? // injected
    
    @IBOutlet weak var emailTextField: ProdriveTextField!
    @IBOutlet weak var passwordTextField: ProdriveTextField!
    @IBOutlet weak var loginButton: ProdriveButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
        interactor?.fetchUserProfileAndNotify(email: email, password: password)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.onStart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor?.onStop()
    }
}

extension LoginViewController: LoginViewMvc {
    
    func showLoadingIndicator() {
        loginButton.showLoading()
    }
    
    func hideLoadingIndicator() {
        loginButton.hideLoading()
    }
    
    func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}
