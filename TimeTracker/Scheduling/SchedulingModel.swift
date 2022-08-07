//
//  SchedulingModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

struct SchedulingModel {
    var schedules: [Schedule]
    
    struct Schedule {
        var scheduleName: String
        var startDate: Date
        var endDate: Date
    }
}
