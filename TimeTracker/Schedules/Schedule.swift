//
//  Schedule.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

struct Schedule: Codable, Identifiable, Hashable {
    let id: UUID
    let scheduleName: String
    let startDate: Date
    let endDate: Date
    let activities: [Activity]
}

struct Activity: Codable, Hashable {
    let date: Date
    let category: Category
}
