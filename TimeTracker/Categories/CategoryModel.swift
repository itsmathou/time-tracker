//
//  CategoryModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

struct Category: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let iconName: String
}
