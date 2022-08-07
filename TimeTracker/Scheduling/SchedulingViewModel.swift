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
    private let fileManager: FileManagement
    
    init(fileManager: FileManagement = TTFileManager()) {
        self.fileManager = fileManager
    }
    
    func save(schedule: SchedulingModel.Schedule) {
        if let existingSchedules = loadExistingSchedulesIfNeeded(), let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            var newListOfSchedules = existingSchedules.schedules
            newListOfSchedules.append(schedule)
            let newModel = SchedulingModel(schedules: newListOfSchedules)
            let data = try? JSONEncoder().encode(newModel)
            try? data?.write(to: scheduleUrl)
        } else if let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            let model = SchedulingModel(schedules: [schedule])
            let data = try? JSONEncoder().encode(model)
            try? data?.write(to: scheduleUrl)
        } else {
            fatalError("Something went really wrong")
        }
    }
}

private extension SchedulingViewModel {
    func loadExistingSchedulesIfNeeded() -> SchedulingModel? {
        return fileManager.loadSchedules()
    }
}
