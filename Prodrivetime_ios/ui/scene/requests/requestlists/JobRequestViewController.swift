//
//  JobRequestViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/19/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import UIKit

protocol JobRequestViewMvc: class{
    func populateTable(requests: [JobRequest])
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showEmptyState()
    func hideEmptyState()
}

class JobRequestViewController: BaseViewController, Storyboarded {
    
    private let freshControl = UIRefreshControl()
    private let cellId = "ProdriveJobRequestCell"
    private let dataSource = JobRequestDataSource()
    
    private var originalRequests = [JobRequest]()
    private var filteredRequests = [JobRequest]()
    
    private var searchController: UISearchController!
    @IBOutlet weak var jobRequestTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    // All dependencies will be injected by the tabbar controller
    
    var interactor: JobRequestInteractor?
    var email: String?
    weak var coordinator: JobRequestCoordinator?
    
    // MARK: - lifecycle callback
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
        configureInteractor()
        
        interactor?.onStart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startRequestFetch()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        interactor?.onStop()
    }
    
    // MARK: - configurations
    
    func configureInteractor() {
        interactor?.bindEmail(email: email)
    }
    
    func configureTableView() {
        loadingIndicator.hidesWhenStopped = true
        jobRequestTableView.dataSource = dataSource
        jobRequestTableView.delegate = self
        jobRequestTableView.separatorColor = UIColor.clear
        jobRequestTableView.keyboardDismissMode = .onDrag
        jobRequestTableView.tableFooterView = UIView() // to remove separator between empty cells
        jobRequestTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        jobRequestTableView.refreshControl = freshControl
        freshControl.addTarget(self, action: #selector(startRequestFetch), for: .valueChanged)
    }
    
    func configureSearchBar() {
        searchbar.delegate = self
    }
    
    // MARK: - owner inplementation
    
    @objc private func startRequestFetch() {
        interactor?.fetchJobRequestAndNotify()
    }
}

// MARK: - presenter callback

extension JobRequestViewController: JobRequestViewMvc {
    
    func populateTable(requests: [JobRequest]) {
        originalRequests = requests
        dataSource.requests = originalRequests
        jobRequestTableView.reloadData()
        freshControl.endRefreshing()
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        freshControl.endRefreshing()
    }
    
    func showEmptyState() {
        guard let image = UIImage(named: "emptystate") else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        jobRequestTableView.reloadData()
        jobRequestTableView.backgroundView = imageView
        jobRequestTableView.separatorColor = UIColor.clear
    }
    
    func hideEmptyState() {
        jobRequestTableView.backgroundView = nil
        jobRequestTableView.separatorColor = UIColor.lightGray
    }
}

// MARK: - TableView delegate callback

extension JobRequestViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredRequests.count != 0 {
            coordinator?.pushToDetailView(request: filteredRequests[indexPath.row], rowSelected: indexPath.row)
        } else {
            coordinator?.pushToDetailView(request: originalRequests[indexPath.row], rowSelected: indexPath.row)
        }
    }
}

// MARK: - DeleteTableRowDelegate callback

extension JobRequestViewController: DeleteTableRowDelegate {
    func deleteRow(at row: Int) {
        originalRequests.remove(at: row)
        jobRequestTableView.beginUpdates()
        jobRequestTableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .fade)
        jobRequestTableView.endUpdates()
    }
}

// MARK: - UISearchBarDelegate callback

extension JobRequestViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 0 {
            
            let filterRequest = originalRequests.filter { (request) -> Bool in
                return request.title.replacingOccurrences(of: " ", with: "").lowercased().contains(searchText.replacingOccurrences(of: " ", with: "").lowercased())
            }
            
            filteredRequests = filterRequest

            dataSource.requests = filterRequest
            
        } else {
            dataSource.requests = originalRequests
            filteredRequests.removeAll()
        }
        jobRequestTableView.reloadData()
    }
}
