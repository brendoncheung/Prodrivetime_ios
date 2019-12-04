//
//  ProdriveJobRequestCell.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/21/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

class ProdriveJobRequestCell: BaseTableViewCell<JobRequestHistory> {
    
    @IBOutlet weak var offer: UILabel!
    
    @IBOutlet weak var requestImage: ProdriveImage!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var company: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = UITableViewCell.SelectionStyle.none
    }

}
