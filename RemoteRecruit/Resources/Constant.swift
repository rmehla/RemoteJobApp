//
//  Constant.swift
//  RemoteRecruit
//
//  Created by rmehla on 05/06/26.
//

import Foundation
import UIKit

extension String {
    static let empty = ""
    static let space = " "
    static let tabSpace = "    "
    static let rupeeSymbol = "\u{0024}"
    
    func customisedTextColorBlack(headingLabel: String, compositeString: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: compositeString)
        attributedString.addAttribute(.foregroundColor, value: UIColor.darkText, range: NSRange(location: 0, length: headingLabel.count))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 0, length: headingLabel.count))
        return attributedString
    }
}
