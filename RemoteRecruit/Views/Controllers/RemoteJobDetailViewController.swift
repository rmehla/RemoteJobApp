//
//  RemoteJobDetailViewController.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import UIKit
import SwiftUI
import Combine

struct RemoteJobDetailViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RemoteJobDetailViewController {
        return RemoteJobDetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: RemoteJobDetailViewController, context: Context) {
        // Leave empty unless you need to update the controller dynamically
    }
}

class RemoteJobDetailViewController: UIViewController {
    @IBOutlet var companyImageView : UIImageView?
    
    @IBOutlet var positionLabel : UILabel?
    @IBOutlet var companyLabel : UILabel?
    @IBOutlet var salaryLabel : UILabel?
    @IBOutlet var locationLabel : UILabel?
    @IBOutlet var jobDescLabel : UILabel?
    @IBOutlet var noDataView : UIView?
       
    var jobId: Int?
    var remoteJobDetailViewModel: RemoteJobDetailViewModel?
    
    private var cancellables = Set<AnyCancellable>()

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Register your custom cell class
        self.navigationController?.navigationBar.isHidden = true
        getRemoteJobDetail(jobId: self.jobId)
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getRemoteJobDetail(jobId: Int?) {
        guard let jobId = jobId else {
            return
        }
        remoteJobDetailViewModel?.$remoteJobDetail
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] jobDetail in
                ContentLoader.hide(from: self?.noDataView ?? UIView())

                self?.displayRemoteJobDetail()
            }
            .store(in: &cancellables)
        
        remoteJobDetailViewModel?.$error
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showHideNoDataView()
            }
            .store(in: &cancellables)

        ContentLoader.show(on: noDataView ?? UIView())
//        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { [weak self] timer in
            self.remoteJobDetailViewModel?.getRemoteJobDetail(jobId: jobId)
 //       }
    }
    
    func displayRemoteJobDetail() {
        self.positionLabel?.attributedText = self.remoteJobDetailViewModel?.positionText

        self.companyLabel?.attributedText = self.remoteJobDetailViewModel?.companyText
        self.salaryLabel?.attributedText = self.remoteJobDetailViewModel?.salaryText

        self.locationLabel?.attributedText = self.remoteJobDetailViewModel?.locationText
        self.jobDescLabel?.attributedText = self.remoteJobDetailViewModel?.descriptionText
    }
    
    func showHideNoDataView() {
        EmptyStateView.show(on: self.noDataView ?? UIView())
    }
}
