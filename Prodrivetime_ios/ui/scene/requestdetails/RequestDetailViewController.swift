//
//  RequestDetailViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/23/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

protocol RequestDetailViewMvc: class {
    func populateUI(request: JobRequest)
    func showAlertDialog(title: String, message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func onAcceptSuccessful()
    func openCallDialog(url: URL)
    
    func showLoadingIndicatorOnAcceptButton()
    func hideLoadingIndicatorOnAcceptButton()
    
    func showLoadingIndicatorOnCallButton()
    func hideLoadingIndicatorOnCallButton()
}
protocol DeleteTableRowDelegate: class {
    func deleteRow(at row: Int)
}

class RequestDetailViewController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var offeringLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var requestIdLabel: UILabel!
    @IBOutlet weak var pickupAddressLabel: UILabel!
    @IBOutlet weak var dropoffAddressLabel: UILabel!
    @IBOutlet weak var jobPostedDateLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    
    @IBOutlet weak var callButton: ProdriveButton!
    @IBOutlet weak var acceptButton: ProdriveButton!
    @IBOutlet weak var loadWeightLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var user: User?
    var request: JobRequest?
    var interator: RequestDetailInteractor?
    var rowSelected: Int!
    
    weak var delegate: DeleteTableRowDelegate?
    weak var coordinator: JobRequestCoordinator?
    
    override func viewDidLoad() {
        loadingIndicator.hidesWhenStopped = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interator?.bindRequest(request: request)
        interator?.bindUserProfile(user: user)
        interator?.onStart()
    }
    
    // MARK: - IBAction
    
    @IBAction func onCallButtonTapped(_ sender: Any) {
        interator?.handleCallButtonTapped()
    }
    
    @IBAction func onAcceptButtonTapped(_ sender: Any) {
        showAlertDialog(title: "Are you sure", message: "Let's hit the road")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interator?.onStop()
    }
}

extension RequestDetailViewController: RequestDetailViewMvc {
    
    func populateUI(request: JobRequest) {
        titleLabel.text = request.title
        offeringLabel.text = StringFormatter.convertStringToCurrency(string: request.price)
        emailLabel.text = request.businessEmail
        requestIdLabel.text = "\(request.requestID)"
        pickupAddressLabel.text = request.pickupAddress
        dropoffAddressLabel.text = request.dropOffAddress
        jobPostedDateLabel.text = request.timestamp
        deliveryDateLabel.text = request.deliveryDate
        jobDescriptionLabel.text = request.detail
        loadWeightLabel.text = request.loadWeight + " Lbs"
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func showAlertDialog(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let accept = UIAlertAction(title: "Accept", style: .default) { (action) in
            self.interator?.handleAcceptButtonTapped()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        
        alertController.addAction(accept)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func onAcceptSuccessful() {
        coordinator?.popBack()
        //delegate?.deleteRow(at: rowSelected)
    }
    
    func openCallDialog(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func showLoadingIndicatorOnAcceptButton() {
        acceptButton.showLoading()
    }
    
    func hideLoadingIndicatorOnAcceptButton() {
        acceptButton.hideLoading()
    }
    
    func showLoadingIndicatorOnCallButton() {
        callButton.showLoading()
    }
    
    func hideLoadingIndicatorOnCallButton() {
        callButton.hideLoading()
    }
}

