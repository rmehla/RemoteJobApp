//
//  NetworkError.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case badURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case unknown
    
    // MARK: - Equatable
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL),
             (.unknown, .unknown):
            return true

        case (.requestFailed(let leftErr), .requestFailed(let rightErr)):
            // Compare by error type + description
            return type(of: leftErr) == type(of: rightErr) &&
                leftErr.localizedDescription == rightErr.localizedDescription

        case (.decodingFailed(let leftErr), .decodingFailed(let rightErr)):
            return type(of: leftErr) == type(of: rightErr) &&
                leftErr.localizedDescription == rightErr.localizedDescription

        default:
            return false
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Invalid URL"
        case .requestFailed(let err):
            return "Request failed: \(err.localizedDescription)"
        case .decodingFailed(let err):
            return "Decoding failed: \(err.localizedDescription)"
        case .unknown:
            return "Unknown error"
        }
    }
}
