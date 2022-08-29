//
//  Schedule+Stub.swift
//  TimeTracker
//

import Extensions
import Foundation

#if DEBUG
extension Schedule {
    public static let firstStubSchedule: Self = .init(
        id: UUID(),
        scheduleName: "July 2021",
        startDate: Date.create(day: 1, month: 7, year: 2021)!,
        endDate: Date.create(day: 31, month: 7, year: 2021)!,
        activities: []
    )
    
    public static let secondStubSchedule: Self = .init(
        id: UUID(),
        scheduleName: "August 2021",
        startDate: Date.create(day: 1, month: 8, year: 2021)!,
        endDate: Date.create(day: 31, month: 8, year: 2021)!,
        activities: []
    )
}
#endif
