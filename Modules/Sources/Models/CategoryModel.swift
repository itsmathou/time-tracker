import Foundation

public struct TTCategory: Identifiable, Codable, Hashable {
    public let id: UUID
    public let name: String
    public let iconName: String
    
    public init(
        id: UUID,
        name: String,
        iconName: String
    ) {
        self.id = id
        self.name = name
        self.iconName = iconName
    }
}
