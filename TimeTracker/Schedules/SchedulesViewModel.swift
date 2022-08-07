//
//  SchedulesViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

protocol Schedules {
    var schedules: [SchedulingModel.Schedule]? { get }
}

final class SchedulesViewModel: Schedules {
    var schedules: [SchedulingModel.Schedule]?
    
    init() {
        schedules = loadSchedules()
    }
}

private extension SchedulesViewModel {
    func loadSchedules() -> [SchedulingModel.Schedule]? {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let documentsUrl = NSURL(fileURLWithPath: documentPath)
        guard let scheduleUrl = documentsUrl.appendingPathComponent("time-tracker.json"), let existingSchedules = try? Data(contentsOf: scheduleUrl) else {
            return nil
        }
        
        let scheduleModel = try? JSONDecoder().decode(SchedulingModel.self, from: existingSchedules)
        return scheduleModel?.schedules
    }
}
