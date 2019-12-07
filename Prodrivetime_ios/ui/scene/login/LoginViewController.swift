//
//  ViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/12/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit
import SafariServices

protocol LoginViewMvc: class {
    func showLoadingIndicator()
    func showSignUpPage(url: URL)
    func hideLoadingIndicator()
    func showAlert(title: String, description: String)
    func hideLoginInterface()
}

class LoginViewController: BaseViewController, Storyboarded {
    
    var interactor: LoginInteractor? // injected
    
    @IBOutlet weak var emailTextField: ProdriveTextField!
    @IBOutlet weak var passwordTextField: ProdriveTextField!
    @IBOutlet weak var loginButton: ProdriveButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialSwitchState()
        interactor?.handleSwitchState(isOn: rememberMeSwitch.isOn)
    }
    
    // MARK: - IBActions
    
    @IBAction func onSwitchTapped(_ sender: UISwitch) {
        interactor?.handleSwitchState(isOn: sender.isOn)
    }
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        interactor?.handleLoginButtonTapped(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func onSignUpButtonTapped(_ sender: Any) {
        interactor?.handleSignUpButtonTapped()
     }
    
    // MARK: - Lifecycle callback
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.onStart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor?.onStop()
    }
    
    // MARK: - Configuration
    
    private func configureInitialSwitchState() {
        // making sure the switch is always in a defined state
        rememberMeSwitch.setOn(false, animated: true)
    }
}

    // MARK: Presenter Callbacks

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
    
    func showSignUpPage(url: URL) {
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func hideLoginInterface() {
        
    }
}
