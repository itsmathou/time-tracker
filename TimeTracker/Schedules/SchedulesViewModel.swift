//
//  SchedulesViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

protocol Schedules {
    var schedules: [Schedule]? { get }
    func save(schedule: Schedule)
}

final class SchedulesViewModel: Schedules {
    private let fileManager: FileManagement

    var schedules: [Schedule]?
    
    init(fileManager: FileManagement = TTFileManager()) {
        self.fileManager = fileManager
        schedules = loadSchedules()
    }
    
    func save(schedule: Schedule) {
        if let existingSchedules = loadSchedules(),
           let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            var newListOfSchedules = existingSchedules
            newListOfSchedules.append(schedule)
            let data = try? JSONEncoder().encode(newListOfSchedules)
            try? data?.write(to: scheduleUrl)
        } else if let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            let model = [schedule]
            let data = try? JSONEncoder().encode(model)
            try? data?.write(to: scheduleUrl)
        } else {
            fatalError("Something went really wrong")
        }
    }
}

private extension SchedulesViewModel {
    func loadSchedules() -> [Schedule]? {
        return fileManager.loadSchedules()
    }
}
