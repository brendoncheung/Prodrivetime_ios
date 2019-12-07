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
    func showLoginInterface()
}

class LoginViewController: BaseViewController, Storyboarded {
    
    var interactor: LoginInteractor? // injected
    
    @IBOutlet weak var emailTextField: ProdriveTextField!
    @IBOutlet weak var passwordTextField: ProdriveTextField!
    @IBOutlet weak var loginButton: ProdriveButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var loginInterface: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.bindSwitchState(isOn: rememberMeSwitch.isOn)
    }
    
    // MARK: - IBActions
    
    @IBAction func onSwitchTapped(_ sender: UISwitch) {
        interactor?.bindSwitchState(isOn: sender.isOn)
    }
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        interactor?.handleLoginButtonTapped(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func onSignUpButtonTapped(_ sender: Any) {
        interactor?.handleSignUpButtonTapped()
     }
    
    // MARK: - Lifecycle callback
    
    // Attaching the delegates in the interactor onces user logout
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.onStart()
    }
    
    // This is to bring the login interface back when the sign logout
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        interactor?.onStop()
        loginInterface.isHidden = false
    }
    
    // MARK: - Configuration
    
    private func configureInitialSwitchState() {
        // making sure the switch is always in a defined state
        rememberMeSwitch.setOn(true, animated: true)
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
        loginInterface.isHidden = true
    }
    
    func showLoginInterface() {
        loginInterface.isHidden = false
    }
}
