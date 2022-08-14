//
//  SchedulesViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

final class SchedulesViewModel: ObservableObject {
    private let fileManager: FileManagement

    @Published var schedules: [Schedule]?
    @Published var selectedSchedules = Set<Schedule>()
    @Published var categories: [Category] = []
    @Published var selectedCategory: Category?
    
    init(fileManager: FileManagement = TTFileManager()) {
        self.fileManager = fileManager
        schedules = loadSchedules()
        categories = loadCategories()
    }
    
    func save(schedule: Schedule) {
        if let existingSchedules = loadSchedules(),
           let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            var newListOfSchedules = existingSchedules
            newListOfSchedules.append(schedule)
            let data = try? JSONEncoder().encode(newListOfSchedules)
            try? data?.write(to: scheduleUrl)
            schedules = newListOfSchedules
        } else if let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            let model = [schedule]
            let data = try? JSONEncoder().encode(model)
            try? data?.write(to: scheduleUrl)
            schedules = model
        } else {
            fatalError("Something went really wrong")
        }
    }
    
    func deleteSchedules() {
        updateLocalList()
        if let schedules, !schedules.isEmpty, let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            let data = try? JSONEncoder().encode(schedules)
            try? data?.write(to: scheduleUrl)
        } else if let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            do {
                try FileManager.default.removeItem(at: scheduleUrl)
            } catch let error as NSError {
                dump("Something went really wrong: \(error)")
            }
        }
    }
}

private extension SchedulesViewModel {
    func loadSchedules() -> [Schedule]? {
        return fileManager.loadSchedules()
    }
    
    func loadCategories() -> [Category] {
        guard let categories = fileManager.loadCategories() else {
            let defaultCategory = [
                Category(
                    id: UUID(),
                    name: String(localized: "add_activity_default_category") ,
                    iconName: "archivebox"
                )
            ]
            selectedCategory = defaultCategory.first
            return defaultCategory
        }
        selectedCategory = categories.first
        
        return categories
    }
    
    func updateLocalList() {
        for selectedSchedule in selectedSchedules {
            schedules = schedules?.filter { schedule in
                selectedSchedule.id != schedule.id
            }
            selectedSchedules.remove(selectedSchedule)
        }
    }
}
