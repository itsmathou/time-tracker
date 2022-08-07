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
    private let fileManager: FileManagement

    var schedules: [SchedulingModel.Schedule]?
    
    init(fileManager: FileManagement = TTFileManager()) {
        self.fileManager = fileManager
        schedules = loadSchedules()
    }
}

private extension SchedulesViewModel {
    func loadSchedules() -> [SchedulingModel.Schedule]? {
        return fileManager.loadSchedules()?.schedules
    }
}
