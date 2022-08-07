//
//  SchedulingViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

protocol Scheduling {
    func save(schedule: SchedulingModel.Schedule)
}

final class SchedulingViewModel: Scheduling {
    
    func save(schedule: SchedulingModel.Schedule) {
        if let existingSchedules = loadExistingSchedulesIfNeeded(), let scheduleUrl {
            var newListOfSchedules = existingSchedules.schedules
            newListOfSchedules.append(schedule)
            let newModel = SchedulingModel(schedules: newListOfSchedules)
            let data = try? JSONEncoder().encode(newModel)
            try? data?.write(to: scheduleUrl)
        } else if let scheduleUrl {
            let model = SchedulingModel(schedules: [schedule])
            let data = try? JSONEncoder().encode(model)
            try? data?.write(to: scheduleUrl)
        } else {
            fatalError("Something went really wrong")
        }
    }
}

private extension SchedulingViewModel {
    var scheduleUrl: URL? {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let documentsUrl = NSURL(fileURLWithPath: documentPath)
        return documentsUrl.appendingPathComponent("time-tracker.json")
    }

    func loadExistingSchedulesIfNeeded() -> SchedulingModel? {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let documentsUrl = NSURL(fileURLWithPath: documentPath)
        guard let scheduleUrl,
              let existingSchedules = try? Data(contentsOf: scheduleUrl) else {
            return nil
        }
        return try? JSONDecoder().decode(SchedulingModel.self, from: existingSchedules)
    }
}
