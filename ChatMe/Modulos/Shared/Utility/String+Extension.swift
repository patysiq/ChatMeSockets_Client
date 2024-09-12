//
//  String+Extension.swift
//  Utility
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import Foundation

public extension String {
    
    func isEmail() -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
            return emailTest.evaluate(with: self)
        }
    
    func converToDate() -> Date? {
        let dateFromStringFormatter = DateFormatter()
        dateFromStringFormatter.dateFormat = CreateDateFormat
        return dateFromStringFormatter.date(from: self)
    }
}


