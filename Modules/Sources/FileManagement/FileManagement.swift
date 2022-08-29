//
//  FileManagement.swift
//  TimeTracker
//

import Foundation
import Models

public protocol FileManagement {
    func loadSchedules() -> [Schedule]?
    func loadCategories() -> [TTCategory]?
    func documentUrl(for file: FileName) -> URL?
}

public enum FileName: String {
    case categories = "categories.json"
    case schedules = "schedules.json"
}

public final class TTFileManager: FileManagement {
    public init() {}
    public func documentUrl(for fileName: FileName) -> URL? {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let url = NSURL(fileURLWithPath: documentPath)
        return url.appendingPathComponent(fileName.rawValue)
    }
    
    public func loadSchedules() -> [Schedule]? {
        guard let scheduleUrl = documentUrl(for: .schedules),
              let existingSchedules = try? Data(contentsOf: scheduleUrl) else {
            return nil
        }
        
        return try? JSONDecoder().decode([Schedule].self, from: existingSchedules)
    }
    
    public func loadCategories() -> [TTCategory]? {
        guard let categoryUrl = documentUrl(for: .categories),
              let existingCategory = try? Data(contentsOf: categoryUrl) else {
            return nil
        }
        
        return try? JSONDecoder().decode([TTCategory].self, from: existingCategory)
    }
}
