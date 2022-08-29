import Foundation

public enum ScheduleEvent {
    case saveSchedule
    case deleteSchedules
    case saveActivity(Activity, Schedule)
}
