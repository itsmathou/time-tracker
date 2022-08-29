//
//  Schedule.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

public struct Schedule: Codable, Identifiable, Hashable {
    public let id: UUID
    public let scheduleName: String
    public let startDate: Date
    public let endDate: Date
    public let activities: [Activity]
    
    public init(
        id: UUID,
        scheduleName: String,
        startDate: Date,
        endDate: Date,
        activities: [Activity]
    ) {
        self.id = id
        self.scheduleName = scheduleName
        self.startDate = startDate
        self.endDate = endDate
        self.activities = activities
    }
    
    public func getActivitiesByCategory() -> [ActivityList] {
        var previousCategory: TTCategory? = nil
        var activitiesByCategory: [ActivityList] = []
        let sortedActivities = activities.sorted { $0.category.name < $1.category.name }
        for activity in sortedActivities where previousCategory != activity.category {
            let sameCategoryActivities = activities.filter { $0.category == activity.category }
            let activityList = ActivityList(categoryName: activity.category.name, activities: sameCategoryActivities)
            activitiesByCategory.append(activityList)
            previousCategory = activity.category
        }
        
        return activitiesByCategory
    }
}

public struct ActivityList: Identifiable, Hashable {
    public let id = UUID()
    public let categoryName: String
    public let activities: [Activity]

    public init(
        categoryName: String,
        activities: [Activity]
    ) {
        self.categoryName = categoryName
        self.activities = activities
    }
}
