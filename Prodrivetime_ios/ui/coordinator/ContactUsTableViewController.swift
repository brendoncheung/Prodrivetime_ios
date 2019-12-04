
//
//  ContactUsTableViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 12/4/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

class ContactUsTableViewController: UITableViewController, Storyboarded {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.section {
            
            // MARK: - General
            
        case 0:
            
            switch indexPath.row {
                
            case 0:
                log.debug("Technical support")
                
            case 1:
                log.debug("iOS Inquiry")
                
            case 2:
                log.debug("Android Inquiry")
                
            default:
                fatalError("not implemented")
            }
            
        // MARK: - Business
        case 1:
            
            switch indexPath.row {
            case 0:
                log.debug("business")
                
            default:
                fatalError("not implemented")
            }
            
        default:
            fatalError("not implemented")
            
        }
        
        
    }
    
    
    
    
}
