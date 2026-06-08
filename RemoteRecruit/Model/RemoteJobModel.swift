//
//  RemoteJobsModel.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import Foundation

struct RemoteJobModel: Codable, Identifiable {
    let id: Int?
    let position: String?
    let company: String?
    let location: String?
    let description: String?
    let salaryMin: String?
    let salaryMax: String?
    
    // CodingKeys enum for mapping JSON keys to Swift properties
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case position = "position"
        case company = "company"
        case location = "location"
        case description = "description"
        case salaryMin = "salary_min"
        case salaryMax = "salary_max"
    }
    
    // Custom initializer for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode each property safely
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.position = try container.decodeIfPresent(String.self, forKey: .position)
        self.company = try container.decodeIfPresent(String.self, forKey: .company)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.salaryMin = try container.decodeIfPresent(String.self, forKey: .salaryMin)
        self.salaryMax = try container.decodeIfPresent(String.self, forKey: .salaryMax)
    }
    
    init(id: Int?, position: String?, company: String?, location: String?, description: String?, salaryMin: String?, salaryMax: String?) {
        self.id = id
        self.company = company
        self.position = position
        self.location = location
        self.description = description
        self.salaryMin = salaryMin
        self.salaryMax = salaryMax
    }
}
