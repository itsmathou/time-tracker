//
//  FileManagement.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

protocol FileManagement {
    func loadSchedules() -> SchedulingModel?
    var schedulesUrl: URL? { get }
}

final class TTFileManager: FileManagement {
    var schedulesUrl: URL? {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let documentsUrl = NSURL(fileURLWithPath: documentPath)
        return documentsUrl.appendingPathComponent("time-tracker.json")
    }
    
    func loadSchedules() -> SchedulingModel? {
        guard let scheduleUrl = schedulesUrl, let existingSchedules = try? Data(contentsOf: scheduleUrl) else {
            return nil
        }
        
        return try? JSONDecoder().decode(SchedulingModel.self, from: existingSchedules)
    }
}
