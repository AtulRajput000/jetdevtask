//
//  Date+Extension.swift
//  JetDevsHomeWork
//
//    21/12/24.
//

import Foundation

extension Date {
    
    func offsetFrom(date: Date, isShowSeconds: Bool = true, isShowOnlyDays: Bool = false) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
        
        var seconds = ""
        if isShowSeconds == true {
            seconds = "\(difference.second ?? 0)s"
        }
        let minutes = "\(difference.minute ?? 0)min" + " " + seconds
        let hours = "\(difference.hour ?? 0)h" + " " + minutes
        let days = "\(difference.day ?? 0)d" + " " + hours
        
        if isShowOnlyDays == true {
            return "\(difference.day ?? 0)"
        }
        
        if let day = difference.day, day          > 0 { return days.trimWhiteSpace()}
        if let hour = difference.hour, hour       > 0 { return hours.trimWhiteSpace()}
        if let minute = difference.minute, minute > 0 { return minutes.trimWhiteSpace() }
        if let second = difference.second, second > 0 {
            if isShowSeconds == true {
                seconds = "\(difference.second ?? 0)s"
            } else {
                return "0min"
            }
        }
       
        return seconds
    }
}
