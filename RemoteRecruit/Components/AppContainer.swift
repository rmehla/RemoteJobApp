//
//  AppContainer.swift
//  RemoteRecruit
//
//  Created by rmehla on 08/06/26.
//

import Foundation

final class AppContainer {

    lazy var remoteJobService = RemoteJobService()
    lazy var remoteJobRepository =
        RemoteJobRepository(remoteJobAPI: remoteJobService)

    lazy var fetchJobUseCase =
        FetchJobUseCase(repository: remoteJobRepository)

    func makeRemoteJobsViewModel() -> RemoteJobViewModel {
        RemoteJobViewModel(fetchJobUseCase: fetchJobUseCase)
    }

    func makeRemoteJobDetailViewModel() -> RemoteJobDetailViewModel {
        RemoteJobDetailViewModel(fetchJobUseCase: fetchJobUseCase)
    }
}
