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
    
}

class SettingTableViewController: UITableViewController, Storyboarded {
    
    weak var coordinator: SettingCoordinator?
    var interactor: SettingInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let interactor = interactor else {return}
        
        switch indexPath.section {
            
            // MARK: - GENERAL SECTION
            
        case 0 :
            
            switch indexPath.row {
                
            case 0 : // Report A Problem
                coordinator?.pushToReportAProblem()
                
            case 1: // Contact Us
                coordinator?.pushToContactUs()
                
            case 2: // Rate Us
                coordinator?.pushToRateUs()
                tabBarController?.dismiss(animated: true, completion: nil)
            default:
                fatalError("not implemented")
            }
            
            // MARK: - ACCOUNT SECTION
            
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
    
    
}
