//
//  RemoteJobService.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import Foundation
import Combine

protocol RemoteJobServiceProtocol {
    func fetchRemoteJobs() throws -> AnyPublisher<[RemoteJobModel], Error>
    func fetchRemoteJobDetail(jobId: Int) throws -> AnyPublisher<[RemoteJobDetailModel], Error>
}

final class RemoteJobService: RemoteJobServiceProtocol {    
    func fetchRemoteJobs() throws -> AnyPublisher<[RemoteJobModel], Error> {
        let fileURL = Bundle.main.url(forResource: "RemoteJobs", withExtension: "json")

        guard let jobsUrl = fileURL else {
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
        
        return Future<Data, Error> { promise in
            do {
                let data = try Data(contentsOf: jobsUrl)
                promise(.success(data))
            } catch {
                promise(.failure(error))
            }
        }
        .decode(type: [RemoteJobModel].self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func fetchRemoteJobDetail(jobId: Int) throws -> AnyPublisher<[RemoteJobDetailModel], Error> {
        let fileURL = Bundle.main.url(forResource: "RemoteJobDetails", withExtension: "json")
        guard let remoteJobDetailUrl = fileURL else {
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
        
        return Future<Data, Error> { promise in
            do {
                let data = try Data(contentsOf: remoteJobDetailUrl)
                let response = try JSONDecoder().decode([RemoteJobDetailModel].self, from: data)
                print("Response: ", response)
                promise(.success(data))
            } catch {
                promise(.failure(error))
            }
        }
        .decode(type: [RemoteJobDetailModel].self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
