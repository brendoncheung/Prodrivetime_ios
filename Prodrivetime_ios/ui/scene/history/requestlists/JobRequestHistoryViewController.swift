//
//  JobRequestHistoryViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/26/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

protocol JobRequestHistoryViewMvc: class{
    func populateTable(requests: [JobRequestHistory])
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showEmptyState()
    func hideEmptyState()
}

class JobRequestHistoryViewController: BaseViewController, Storyboarded {
    
    private let cellId = "ProdriveJobRequestCell"
    private var dataSource = JobRequestHistoryDataSource()
    private var requestHistory = [JobRequestHistory]()
    private var requestHistoryFiltered = [JobRequestHistory]()
    
    var user: User?
    var interactor: JobRequestHistoryInteractor?
    var coordinator: JobRequestHistoryCoordinator?
    
    @IBOutlet weak var jobRequestHistoryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidesWhenStopped = true
        configureTableView()
        configureSearchBar()
        configureInteractor()
    }
    
    func configureInteractor() {
        guard let user = user else {
            log.debug("user cant be empty")
            return
        }
        interactor?.bindUser(user: user)
        interactor?.onStart()
        interactor?.fetchJobRequestHistory()
        log.debug("history")
    }
    
    func configureTableView() {
        jobRequestHistoryTableView.delegate = self
        jobRequestHistoryTableView.dataSource = dataSource
        jobRequestHistoryTableView.keyboardDismissMode = .onDrag
        jobRequestHistoryTableView.tableFooterView = UIView() // to remove separator between empty cells
        jobRequestHistoryTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
}

extension JobRequestHistoryViewController: JobRequestHistoryViewMvc {
    
    func populateTable(requests: [JobRequestHistory]) {
        requestHistory = requests
        dataSource.requestHistory = requests
        jobRequestHistoryTableView.reloadData()
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func showEmptyState() {
        
    }
    
    func hideEmptyState() {
        
    }
}

extension JobRequestHistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.debug(requestHistory[indexPath.row])
        if requestHistoryFiltered.count != 0 {
            coordinator?.pushToDetailHistory(request: requestHistoryFiltered[indexPath.row])
        } else {
            coordinator?.pushToDetailHistory(request: requestHistory[indexPath.row])
        }
        
    }
    
}

extension JobRequestHistoryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 0 {
            
            let filterRequest = requestHistory.filter { (request) -> Bool in
                return request.title.replacingOccurrences(of: " ", with: "").lowercased().contains(searchText.replacingOccurrences(of: " ", with: "").lowercased())
            }
            
             requestHistoryFiltered = filterRequest

            dataSource.requestHistory = filterRequest
            
        } else {
            dataSource.requestHistory = requestHistory
            requestHistoryFiltered.removeAll()
        }
        jobRequestHistoryTableView.reloadData()
    }
    
}

