//
//  DateFormatter+Ext.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

extension DateFormatter {
    static var examDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy hh:mm"
        dateFormatter.timeZone = .current
        return dateFormatter
    }()
    
    static var timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.timeZone = .current
        return dateFormatter
    }()
    
    static func makeExamDate(from unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(unixTime / 1000))
        return examDateFormatter.string(from: date)
    }
    
    static func makeTime(from unixTime: Int) -> String  {
        let date = Date(timeIntervalSince1970: Double(unixTime / 1000))
        return timeFormatter.string(from: date)
    }
}
