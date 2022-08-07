//
//  FileManagement.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

protocol FileManagement {
    func loadSchedules() -> SchedulingModel?
    func loadCategories() -> [Category]?
    func documentUrl(for file: FileName) -> URL?
}

enum FileName: String {
    case categories = "categories.json"
    case schedules = "time-tracker.json"
}

final class TTFileManager: FileManagement {
    func documentUrl(for fileName: FileName) -> URL? {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let url = NSURL(fileURLWithPath: documentPath)
        return url.appendingPathComponent(fileName.rawValue)
    }
    
    func loadSchedules() -> SchedulingModel? {
        guard let scheduleUrl = documentUrl(for: .schedules),
              let existingSchedules = try? Data(contentsOf: scheduleUrl) else {
            return nil
        }
        
        return try? JSONDecoder().decode(SchedulingModel.self, from: existingSchedules)
    }
    
    func loadCategories() -> [Category]? {
        guard let categoryUrl = documentUrl(for: .categories),
              let existingCategory = try? Data(contentsOf: categoryUrl) else {
            return nil
        }
        
        return try? JSONDecoder().decode([Category].self, from: existingCategory)
    }
}
