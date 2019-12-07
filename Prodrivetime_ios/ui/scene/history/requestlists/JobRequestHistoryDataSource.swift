//
//  JobRequestHistoryDataSource.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/30/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

class JobRequestHistoryDataSource: NSObject, UITableViewDataSource {
    
    var requestHistory = [JobRequestHistory]()
    let cellId = "ProdriveJobRequestCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProdriveJobRequestCell
        
        let request = requestHistory[indexPath.row]
        
        cell.title.text = request.title
        cell.company.text = request.businessName
        cell.location.text = request.pickupAddresss
        cell.offer.text = StringFormatter.convertStringToCurrency(string: request.offering) 
        
        return cell
        
    }
    



}
