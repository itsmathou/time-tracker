//
//  SchedulesViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

protocol Schedules {
    var schedules: [SchedulingModel.Schedule]? { get }
    func save(schedule: SchedulingModel.Schedule)
}

final class SchedulesViewModel: Schedules {
    private let fileManager: FileManagement

    var schedules: [SchedulingModel.Schedule]?
    
    init(fileManager: FileManagement = TTFileManager()) {
        self.fileManager = fileManager
        schedules = loadSchedules()
    }
    
    func save(schedule: SchedulingModel.Schedule) {
        if let existingSchedules = loadSchedules(),
           let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            var newListOfSchedules = existingSchedules
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

private extension SchedulesViewModel {
    func loadSchedules() -> [SchedulingModel.Schedule]? {
        return fileManager.loadSchedules()?.schedules
    }
}
