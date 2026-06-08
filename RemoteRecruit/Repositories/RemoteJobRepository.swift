//
//  RemoteJobRepository.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import Foundation
import Combine

protocol RemoteJobRepositoryProtocol {
    func getRemoteJobs() throws -> AnyPublisher<[RemoteJobModel], Error>
    func getRemoteJobDetail(jobId: Int) throws -> AnyPublisher<RemoteJobDetailModel, Error>
}

final class RemoteJobRepository: RemoteJobRepositoryProtocol {
    private let remoteJobAPI: RemoteJobServiceProtocol
    
    init(remoteJobAPI: RemoteJobServiceProtocol = RemoteJobService()) {
        self.remoteJobAPI = remoteJobAPI
    }

    func getRemoteJobs() throws -> AnyPublisher<[RemoteJobModel], Error> {
        do {
            return try self.remoteJobAPI.fetchRemoteJobs()
        } catch {
            return Fail(error: NetworkError.unknown)
                .eraseToAnyPublisher()
        }
    }
    
    func getRemoteJobDetail(jobId: Int) throws -> AnyPublisher<RemoteJobDetailModel, Error> {
        do {
            return try self.remoteJobAPI
                .fetchRemoteJobDetail(jobId: jobId)
                .tryMap { jobs in
                    guard let job = jobs.first(where: { $0.id == jobId }) else {
                        throw NetworkError.unknown
                    }
                    return job
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
