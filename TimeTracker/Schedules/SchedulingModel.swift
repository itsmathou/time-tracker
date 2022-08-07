//
//  SchedulingModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

struct SchedulingModel: Codable {
    let schedules: [Schedule]
    
    struct Schedule: Codable, Identifiable {
        let id: UUID
        let scheduleName: String
        let startDate: Date
        let endDate: Date
    }
}
