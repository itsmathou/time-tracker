import Foundation

public struct Activity: Codable, Hashable, Identifiable {
    public let id: UUID
    public let date: Date
    public let category: TTCategory
    
    public init(
        id: UUID,
        date: Date,
        category: TTCategory
    ) {
        self.id = id
        self.date = date
        self.category = category
    }
}
