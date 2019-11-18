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
    func alertFormImcomplete()
}

class LoginViewController: BaseViewController, Storyboarded {
    
    var interactor: LoginInteractor?
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: ProdriveTextField!
    @IBOutlet weak var passwordTextField: ProdriveTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidesWhenStopped = true
    }
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        interactor?.fetchUserProfileAndNotify(email: emailTextField.text,
                                              password: passwordTextField.text)
    }
}

extension LoginViewController: LoginViewMvc {
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func alertFormImcomplete() {
        log.debug("form incomplete")
    }
}
