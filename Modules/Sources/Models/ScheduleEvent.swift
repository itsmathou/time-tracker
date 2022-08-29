//
//  ScheduleEvent.swift
//  
//
//  Created by Mathilde Ferrand on 29/08/2022.
//

import Foundation

public enum ScheduleEvent {
    case saveSchedule
    case deleteSchedules
    case saveActivity(Activity, Schedule)
}
