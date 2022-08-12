//
//  MockFileManager.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 12/08/2022.
//

import Foundation

#if DEBUG
final class MockFileManager: FileManagement {
    private let schedules: [Schedule]?

    init(schedules: [Schedule]?) {
        self.schedules = schedules
    }

    func loadSchedules() -> [Schedule]? {
        return schedules
    }
    
    func loadCategories() -> [Category]? {
        return nil
    }
    
    func documentUrl(for file: FileName) -> URL? {
        return nil
    }
}
#endif
