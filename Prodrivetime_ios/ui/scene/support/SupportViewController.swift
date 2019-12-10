//
//  SupportViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

protocol SupportViewControllerViewMvc: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showAlert(title: String, description: String)
    func showQuestionSentSuccessfully()
    func clearForm()
}

class SupportViewController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: ProdriveButton!
    
    var user: User?
    
    var subjectLine: String?
    
    var interactor: SupportInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        interactor?.onStart()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(title: "Support", image: UIImage(named: "support_tab"), tag: 3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        log.debug(self)
    }
    
    @IBAction func onSubmitButtonTapped(_ sender: Any) {
        
        interactor?.submitSupportEmail(subject: subjectTextField.text,
                                       email: emailTextField.text,
                                       body: questionTextView.text)
    }
    
    private func configureTextField() {
        questionTextView.delegate = self
        emailTextField.text = user?.email
        subjectTextField.text = subjectLine
    }
}

extension SupportViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
        
    }
}
 
extension SupportViewController: SupportViewControllerViewMvc {
    
    func showAlert(title: String, description: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let action = UIAlertAction(title: "okay", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func showQuestionSentSuccessfully() {
        let alertController = UIAlertController(title: "Submitted", message: "You message has been successfully submited, our technical staff will review it and respond within 5 business days", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil
        )
    }
    
    func clearForm() {
        questionTextView.text = ""
        subjectTextField.text = ""
        emailTextField.text = ""
    }
    
    func showLoadingIndicator() {
        submitButton.showLoading()
    }
    
    func hideLoadingIndicator() {
        submitButton.hideLoading()
    }
}
