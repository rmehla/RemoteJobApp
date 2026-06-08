//
//  RemoteJobDetailViewModel.swift
//  RemoteRecruit
//
//  Created by rmehla on 08/06/26.
//

import Foundation
import Combine
import UIKit

final class RemoteJobDetailViewModel: ObservableObject {
    // Input
    private let fetchJobUseCase: FetchJobUseCase
    @Published private(set) var remoteJobDetail: RemoteJobDetailModel?

    @Published private(set) var error: NetworkError?
    @Published var showError = false

    var positionText: NSAttributedString {
        let jobPosition = self.remoteJobDetail?.position ?? String.empty
        let positionHeading = "Position:"
        let position = positionHeading + " " + jobPosition

        return position.customisedTextColorBlack(headingLabel: positionHeading, compositeString: position)
    }

    var companyText: NSAttributedString {
        let companyTitle = self.remoteJobDetail?.company ?? String.empty
        let companyHeading = "Company:"
        let company = companyHeading + " " + companyTitle
        
        return company.customisedTextColorBlack(headingLabel: companyHeading, compositeString: company)
    }
        
    var salaryText: NSAttributedString {
        let salaryMin = self.remoteJobDetail?.salaryMin ?? String.empty
        let salaryHeading = "Salary :"
        var salary = salaryHeading + " " + String.rupeeSymbol + salaryMin

        let salaryMax = self.remoteJobDetail?.salaryMax ?? String.empty
        if !salaryMax.isEmpty {
            salary = salary + " to " + String.rupeeSymbol + salaryMax
        }
        return salary.customisedTextColorBlack(headingLabel: salaryHeading, compositeString: salary)
    }
    
    var locationText: NSAttributedString {
        let locality = self.remoteJobDetail?.location?.addressLocality ?? String.empty
        let locationHeading = "Location:"
        var location = locationHeading + " " + locality

        let region = self.remoteJobDetail?.location?.addressRegion ?? String.empty
        if !region.isEmpty {
            location = location + ", " + region
        }

        let country = self.remoteJobDetail?.location?.addressCountry ?? String.empty
        if !country.isEmpty {
            location = location + ", " + country
        }

        let postal = self.remoteJobDetail?.location?.postalCode ?? String.empty
        if !postal.isEmpty {
            location = location + ", " + postal
        }
        return location.customisedTextColorBlack(headingLabel: locationHeading, compositeString: location)
    }
        
    var descriptionText: NSAttributedString {
        let desc = self.remoteJobDetail?.description ?? String.empty
        let descHeading = "Job Description:"
        let description = descHeading + " " + desc

        return description.customisedTextColorBlack(headingLabel: descHeading, compositeString: description)
        }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchJobUseCase: FetchJobUseCase) {
        self.fetchJobUseCase = fetchJobUseCase
    }
    
    func getRemoteJobDetail(jobId: Int) {
        error = nil
        
        fetchJobUseCase.fetch(jobId: jobId)
            .handleEvents()
            .sink { completion in
                switch completion {
                case .finished :
                    break
                case .failure(let error):
                    self.error = NetworkError.unknown
                }
            } receiveValue: { [weak self] jobInfo in
                self?.remoteJobDetail = jobInfo
            }
            .store(in: &cancellables)
    }
}
