import Foundation

#if DEBUG
extension Date {
    public static func create(
        day: Int,
        month: Int,
        year: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil
    ) -> Date? {
        guard let date = DateComponents(calendar: Calendar.current,
                                        year: year,
                                        month: month,
                                        day: day,
                                        hour: hour,
                                        minute: minute,
                                        second: second).date else { return nil }
        return date
    }
}
#endif
