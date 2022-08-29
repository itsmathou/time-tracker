import Foundation
import Models

#if DEBUG
public final class MockFileManager: FileManagement {
    private let schedules: [Schedule]?

    public init(schedules: [Schedule]?) {
        self.schedules = schedules
    }

    public func loadSchedules() -> [Schedule]? {
        return schedules
    }
    
    public func loadCategories() -> [TTCategory]? {
        return nil
    }
    
    public func documentUrl(for file: FileName) -> URL? {
        return nil
    }
}
#endif
