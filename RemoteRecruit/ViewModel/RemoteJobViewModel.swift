//
//  RemoteJobViewModel.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import Foundation
import Combine

final class RemoteJobViewModel: ObservableObject {
    // Input
    private let fetchJobUseCase: FetchJobUseCaseProtocol

    private var remoteJobs: [RemoteJobModel] = []
    @Published var filteredJobs: [RemoteJobModel] = []

    @Published private(set) var error: NetworkError?
    @Published var showError = false
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchJobUseCase: FetchJobUseCaseProtocol) {
        self.fetchJobUseCase = fetchJobUseCase
    }
    
    func loadRemoteJobs() {
        error = nil
        
        fetchJobUseCase.execute()
            .handleEvents()
            .sink { completion in
                switch completion {
                case .finished :
                    break
                case .failure(let error):
                    self.error = NetworkError.unknown
                }
            } receiveValue: { [weak self] jobs in
                self?.filteredJobs = jobs
                self?.remoteJobs = jobs
            }
            .store(in: &cancellables)
    }
    
    func search(text: String) {
        if text.isEmpty {
            self.filteredJobs = self.remoteJobs
        } else {
            let jobs = (self.remoteJobs).filter {
                let positionFlag = $0.position?.localizedCaseInsensitiveContains(text) ?? false
                let companyFlag = $0.company?.localizedCaseInsensitiveContains(text) ?? false
                return (positionFlag || companyFlag)
            }
            self.filteredJobs = jobs
        }
    }
    
    func cancel() {
        self.filteredJobs = self.remoteJobs
    }
}

