//
//  Extension+Date.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

#if DEBUG
extension Date {
    static func create(day: Int, month: Int, year: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date? {
        guard let date = DateComponents(calendar: Calendar.current,
                                        year: year,
                                        month: month,
                                        day: day,
                                        hour: hour,
                                        minute: minute,
                                        second: second).date else { return nil }
        return date
    }
}
#endif
