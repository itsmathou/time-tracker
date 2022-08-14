//
//  Schedule.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

struct Schedule: Codable, Identifiable, Hashable {
    let id: UUID
    let scheduleName: String
    let startDate: Date
    let endDate: Date
    let activities: [Activity]
    
    func getActivitiesByCategory() -> [ActivityList] {
        var previousCategory: Category? = nil
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

struct ActivityList: Identifiable, Hashable {
    let id = UUID()
    let categoryName: String
    let activities: [Activity]
}
