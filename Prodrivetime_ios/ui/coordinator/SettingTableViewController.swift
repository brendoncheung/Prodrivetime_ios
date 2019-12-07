//
//  SettingTableViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

protocol SettingTableViewControllerViewMvc: class {
    
    func proceedToMainLoginScreenAfterLogout()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showAlert(title: String, message: String)
}

class SettingTableViewController: UITableViewController, Storyboarded {
    
    
    
    weak var coordinator: SettingCoordinator?
    var interactor: SettingInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.onStart()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let interactor = interactor else {return}
        
        switch indexPath.section {
            
            // MARK: - General section
            
        case 0 :
            
            switch indexPath.row {
                
            case 0 : // Report A Problem
                coordinator?.pushToReportAProblem()
                
            case 1: // Contact Us
                coordinator?.pushToContactUs()
                
            case 2: // Rate Us
                coordinator?.pushToRateUs()
            default:
                fatalError("not implemented")
            }
            
            // MARK: - Account section
            
        case 1:
            
            switch indexPath.row {
                
            case 0 : // Privacy Policy
                coordinator?.pushToPrivacyPolicy()
                
            case 1: // Logout
                coordinator?.pushToLogOut(logoutHandler: interactor.handleLogout)
                
            default:
                fatalError("not implemented")
            }
            
        default:
            fatalError("not implemented")
        }
    }
}

extension SettingTableViewController: SettingTableViewControllerViewMvc {
    
    func proceedToMainLoginScreenAfterLogout() {
        tabBarController?.dismiss(animated: true, completion: nil)
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
}
