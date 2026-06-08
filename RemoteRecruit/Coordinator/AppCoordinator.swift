//
//  AppCoordinator.swift
//  RemoteRecruit
//
//  Created by rmehla on 08/06/26.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
}

final class AppCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let container: AppContainer

    init(navigationController: UINavigationController,
        container: AppContainer
    ) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let jobsVC = storyboard.instantiateViewController(
            identifier: "RemoteJobsVC"
        ) as! RemoteJobsViewController

        jobsVC.remoteJobModel =
            container.makeRemoteJobsViewModel()
        jobsVC.coordinator = self
        navigationController.setViewControllers(
            [jobsVC],
            animated: false
        )
    }

    func showJobDetail(jobId: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(
            identifier: "RemoteJobDetailVC"
        ) as! RemoteJobDetailViewController

        detailVC.jobId = jobId
        detailVC.remoteJobDetailViewModel =
            container.makeRemoteJobDetailViewModel()
        
        navigationController.pushViewController(
            detailVC,
            animated: true
        )
    }
}
