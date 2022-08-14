//
//  Activity.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 14/08/2022.
//

import Foundation

struct Activity: Codable, Hashable {
    let date: Date
    let category: Category
}
