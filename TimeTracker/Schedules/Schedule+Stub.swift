//
//  Schedule+Stub.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 12/08/2022.
//

import Foundation

#if DEBUG
extension Schedule {
    static let firstStubSchedule: Self = .init(
        id: UUID(),
        scheduleName: "July 2021",
        startDate: Date.create(day: 1, month: 7, year: 2021)!,
        endDate: Date.create(day: 31, month: 7, year: 2021)!,
        activities: []
    )
    
    static let secondStubSchedule: Self = .init(
        id: UUID(),
        scheduleName: "August 2021",
        startDate: Date.create(day: 1, month: 8, year: 2021)!,
        endDate: Date.create(day: 31, month: 8, year: 2021)!,
        activities: []
    )
}
#endif
