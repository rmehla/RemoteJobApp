//
//  RemoteJobCell.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import UIKit

class RemoteJobCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!

    // MARK:- Variable
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureRow(with remoteJobInfo: RemoteJobModel) {
        if let jobPosition = remoteJobInfo.position {
            let jobHeading = "Job :"
            let position = jobHeading + " " + jobPosition
            
            self.positionLabel?.attributedText = position.customisedTextColorBlack(headingLabel: jobHeading, compositeString: position)
        }
        
        if let companyTitle = remoteJobInfo.company {
            let companyHeading = "Company :"
            let company = companyHeading + " " + companyTitle
            
            self.companyLabel?.attributedText = company.customisedTextColorBlack(headingLabel: companyHeading, compositeString: company)
        }
        
        if let locationTitle = remoteJobInfo.location {
            let locationHeading = "Location :"
            let location = locationHeading + " " + locationTitle
            
            self.locationLabel?.attributedText = location.customisedTextColorBlack(headingLabel: locationHeading, compositeString: location)
        }
        
        if let salaryMin = remoteJobInfo.salaryMin {
            let salaryHeading = "Salary :"
            var salary = salaryHeading + " " + String.rupeeSymbol + salaryMin
            if let salaryMax = remoteJobInfo.salaryMax {
                salary = salary + " to " + String.rupeeSymbol + salaryMax
            }
            self.salaryLabel?.attributedText = salary.customisedTextColorBlack(headingLabel: salaryHeading, compositeString: salary)
        }
    }
}
