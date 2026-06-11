//
//  RemoteJobsViewController.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import UIKit
import SwiftUI
import Combine

struct RemoteJobsViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RemoteJobsViewController {
        return RemoteJobsViewController()
    }
    
    func updateUIViewController(_ uiViewController: RemoteJobsViewController, context: Context) {
        // Leave empty unless you need to update the controller dynamically
    }
}

class RemoteJobsViewController: UIViewController {
    
    @IBOutlet var remoteJobsTableView : UITableView?
    @IBOutlet var noDataView : UIView?
    @IBOutlet weak var searchBar: UISearchBar!

    var remoteJobModel: RemoteJobViewModel?
    var filteredJobs: [RemoteJobModel] = []
    
    weak var coordinator: AppCoordinator?
    private var cancellables = Set<AnyCancellable>()

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Register your custom cell class
        self.navigationController?.navigationBar.isHidden = true
        self.searchBar.delegate = self
        setupAccessibilityIdentifier()
        setUpTableView()
    }

    private func setUpTableView() {
        let cartCellNib = UINib(nibName: "RemoteJobCell", bundle: nil)
        remoteJobsTableView?.register(cartCellNib, forCellReuseIdentifier: "RemoteJobCell")
        
        remoteJobsTableView?.dataSource = self
        remoteJobsTableView?.delegate = self
        getRemoteJobsList()
   }
    
    func setupAccessibilityIdentifier() {
        self.searchBar.searchTextField.accessibilityIdentifier = "jobsSearchBar"
        self.remoteJobsTableView?.accessibilityIdentifier = "jobsTableView"
        self.noDataView?.accessibilityIdentifier = "emptyStateView"
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
    }
    
    func getRemoteJobsList() {
        ContentLoader.show(on: noDataView ?? UIView())
//        Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { [weak self] timer in
        self.remoteJobModel?.loadRemoteJobs()
//        }
        
        remoteJobModel?.$filteredJobs
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] jobs in
                self?.showHideNoDataView()
                self?.remoteJobsTableView?.reloadData()
            }
            .store(in: &cancellables)
        
        remoteJobModel?.$error
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showHideNoDataView()
            }
            .store(in: &cancellables)
    }
    
    func showHideNoDataView() {
        ContentLoader.hide(from: self.noDataView ?? UIView())

        guard let jobs = self.remoteJobModel?.filteredJobs else { return }
        let noJobsAvailable = jobs.count > 0

        noJobsAvailable ? EmptyStateView.hide(from: self.noDataView ?? UIView()) : EmptyStateView.show(on: self.noDataView ?? UIView())
    }
}

extension RemoteJobsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remoteJobModel?.filteredJobs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RemoteJobCell = tableView.dequeueReusableCell(withIdentifier: "RemoteJobCell", for: indexPath) as! RemoteJobCell
        cell.selectionStyle = .none
        guard let remoteJobInfo = remoteJobModel?.filteredJobs[indexPath.row] else { return UITableViewCell() }
        cell.configureRow(with: remoteJobInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let remoteJobInfo = remoteJobModel?.filteredJobs[indexPath.row]
        guard let jobId = remoteJobInfo?.id else {return}
 
        coordinator?.showJobDetail(jobId: jobId)
    }
}

extension RemoteJobsViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        remoteJobModel?.search(text: searchText)
        showHideNoDataView()
        self.remoteJobsTableView?.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        remoteJobModel?.cancel()
        self.remoteJobsTableView?.reloadData()
        searchBar.resignFirstResponder()
    }
}
