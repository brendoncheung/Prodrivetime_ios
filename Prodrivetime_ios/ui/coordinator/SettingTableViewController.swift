//
//  SettingTableViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class SettingTableViewController: UITableViewController, Storyboarded {
    
    private var coordinator: SettingCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
                
            default:
                fatalError("not implemented")
            }
            
            // MARK: - ACCOUNT SECTION
            
        case 1:
            
            switch indexPath.row {
                
            case 0 : // Privacy Policy
                log.debug("privacy policy")
                
            case 1: // Logout
                log.debug("logout")
                
            default:
                fatalError("not implemented")
            }
            
        default:
            fatalError("not implemented")
        }
        
    }
    
}


