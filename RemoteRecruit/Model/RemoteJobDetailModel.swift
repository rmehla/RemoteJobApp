//
//  RemoteJobDetailModel.swift
//  RemoteRecruit
//
//  Created by rmehla on 06/06/26.
//

import Foundation

struct RemoteJobDetailModel: Codable, Identifiable {
    let id: Int?
    let position: String?
    let company: String?
    let description: String?
    let isRemote: Bool?
    let isHybrid: Bool?
    let salaryMin: String?
    let salaryMax: String?
    let location: RemoteJobLocationModel?

    // CodingKeys enum for mapping JSON keys to Swift properties
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case position = "position"
        case company = "company"
        case location = "location"
        case description = "description"
        case isRemote = "is_remote"
        case isHybrid = "is_hybrid"
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
        self.location = try container.decodeIfPresent(RemoteJobLocationModel.self, forKey: .location)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.isRemote = try container.decodeIfPresent(Bool.self, forKey: .isRemote)
        self.isHybrid = try container.decodeIfPresent(Bool.self, forKey: .isHybrid)
        self.salaryMin = try container.decodeIfPresent(String.self, forKey: .salaryMin)
        self.salaryMax = try container.decodeIfPresent(String.self, forKey: .salaryMax)
    }
    
    init(id: Int?, position: String?, company: String?, location: RemoteJobLocationModel?, description: String?, isRemote: Bool?, isHybrid: Bool?, salaryMin: String?, salaryMax: String?) {
        self.id = id
        self.company = company
        self.position = position
        self.location = location
        self.description = description
        self.isRemote = isRemote
        self.isHybrid = isHybrid
        self.salaryMin = salaryMin
        self.salaryMax = salaryMax
    }
}

struct RemoteJobLocationModel: Codable {
    let streetAddress: String?
    let addressLocality: String?
    let addressRegion: String?
    let postalCode: String?
    let addressCountry: String?

    // CodingKeys enum for mapping JSON keys to Swift properties
    enum CodingKeys: String, CodingKey {
        case streetAddress = "streetAddress"
        case addressLocality = "addressLocality"
        case addressRegion = "addressRegion"
        case postalCode = "postalCode"
        case addressCountry = "addressCountry"
    }
    
    // Custom initializer for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode each property safely
        self.streetAddress = try container.decodeIfPresent(String.self, forKey: .streetAddress)
        self.addressLocality = try container.decodeIfPresent(String.self, forKey: .addressLocality)
        self.addressRegion = try container.decodeIfPresent(String.self, forKey: .addressRegion)
        self.postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode)
        self.addressCountry = try container.decodeIfPresent(String.self, forKey: .addressCountry)
    }
    
    init(streetAddress: String?, addressLocality: String?, addressRegion: String?, postalCode: String?, addressCountry: String?) {
        self.streetAddress = streetAddress
        self.addressRegion = addressRegion
        self.addressLocality = addressLocality
        self.postalCode = postalCode
        self.addressCountry = addressCountry
    }
}
