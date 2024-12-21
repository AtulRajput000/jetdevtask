//
//  String+Extension.swift
//  JetDevsHomeWork
//
//    21/12/24.
//

import Foundation

extension String {
    
    func trimWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func dateFormString(format: String, timeZone: TimeZone? = nil, locale: Locale? = nil) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        var lDate = formatter.date(from: self)
        if lDate == nil {
            var lLocale = Locale(identifier: "en_US_POSIX")
            if let lParameterLocale = locale {
                lLocale = lParameterLocale
            }
            let lDateFormatter = DateFormatter()
            lDateFormatter.dateFormat = format
            lDateFormatter.locale = lLocale
            lDateFormatter.timeZone = timeZone
            lDate = lDateFormatter.date(from: self)
        }
        return lDate ?? Date()
    }
    
    func isValidEmail() -> Bool {
        let email = self
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
