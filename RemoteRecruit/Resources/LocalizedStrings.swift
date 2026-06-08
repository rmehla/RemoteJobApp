//
//  LocalizedStrings.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import Foundation

enum LocalizedStrings {
    static let loginTitle = "User login"
    static let userName = "User name"
    static let password = "Password"
    static let enterUserName = "Enter user name"
    static let enterPassword = "Enter your password"
    static let submit = "Submit"
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
