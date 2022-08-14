//
//  SchedulesViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

enum ScheduleEvent {
    case saveSchedule(Schedule)
    case deleteSchedule
    case saveActivity(Activity, Schedule)
}

final class SchedulesViewModel: ObservableObject {
    private let fileManager: FileManagement

    @Published var schedules: [Schedule]?
    @Published var selectedSchedules = Set<Schedule>()
    @Published var categories: [Category] = []
    @Published var selectedCategory: Category?
    @Published var activityDate = Date()
    
    init(fileManager: FileManagement = TTFileManager()) {
        self.fileManager = fileManager
        schedules = loadSchedules()
        categories = loadCategories()
    }
    
    func handle(event: ScheduleEvent) {
        switch event {
        case let .saveSchedule(schedule):
            print("Save schedule tapped \(schedule)")
        case .deleteSchedule:
            print("Delete schedule tapped")
        case let .saveActivity(activity, schedule):
            save(activity: activity, for: schedule)
        }
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
    
    func save(activity: Activity, for schedule: Schedule) {
        var newScheduleActivities = schedule.activities
        newScheduleActivities.append(activity)
        let newSchedule = Schedule(
            id: schedule.id,
            scheduleName: schedule.scheduleName,
            startDate: schedule.startDate,
            endDate: schedule.endDate,
            activities: newScheduleActivities
        )
        replace(schedule: newSchedule)
    }
    
    func replace(schedule: Schedule) {
        if let schedules,
           let scheduleUrl = fileManager.documentUrl(for: .schedules) {
            var newListOfSchedules = schedules.filter { $0.id != schedule.id }
            newListOfSchedules.append(schedule)
            let data = try? JSONEncoder().encode(newListOfSchedules)
            try? data?.write(to: scheduleUrl)
            self.schedules = newListOfSchedules
        } else {
            print("Something wrong happed")
        }
    }
}
