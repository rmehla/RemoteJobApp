//
//  FetchJobUseCase.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import Foundation
import Combine

protocol FetchJobUseCaseProtocol {
    func execute() -> AnyPublisher<[RemoteJobModel], Error>
    func fetch(jobId: Int) -> AnyPublisher<RemoteJobDetailModel, Error>
}

struct FetchJobUseCase : FetchJobUseCaseProtocol {
    let repository: RemoteJobRepositoryProtocol
    
    init(repository: RemoteJobRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[RemoteJobModel], Error> {
        do {
            return try repository.getRemoteJobs()
        } catch {
            return Fail(error: NetworkError.unknown)
                .eraseToAnyPublisher()
        }
    }
    
    func fetch(jobId: Int) -> AnyPublisher<RemoteJobDetailModel, Error> {
        do {
            return try repository.getRemoteJobDetail(jobId: jobId)
        } catch {
            return Fail(error: NetworkError.unknown)
                .eraseToAnyPublisher()
        }
    }
}
