//
//  JobRequestDataSource.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/23/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

class JobRequestDataSource: NSObject, UITableViewDataSource {
    
    var requests = [JobRequest]() 
    let cellId = "ProdriveJobRequestCell"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProdriveJobRequestCell
        let request = requests[indexPath.row]
        
        cell.title.text = request.title
        cell.company.text = request.businessName
        cell.location.text = request.pickupAddress
        cell.offer.text = "$ " + request.price
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
