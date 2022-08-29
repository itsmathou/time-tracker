//
//  CategoriesViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation
import Models
import Utilities

public final class CategoriesViewModel: ObservableObject {
    private let fileManager: FileManagement
    @Published var items: [TTCategory]?
    
    public init(fileManager: FileManagement = TTFileManager()) {
        self.fileManager = fileManager
        items = loadExistingCategories()
    }
    
    func save(category: String, iconName: String) {
        if let existingCategories = loadExistingCategories(),
           let categoriesUrl = fileManager.documentUrl(for: .categories) {
            var newListOfCategories = existingCategories
            newListOfCategories.append(TTCategory(id: UUID(), name: category, iconName: iconName))
            let data = try? JSONEncoder().encode(newListOfCategories)
            try? data?.write(to: categoriesUrl)
            items = newListOfCategories
        } else if let categoryUrl = fileManager.documentUrl(for: .categories) {
            let categories = [TTCategory(id: UUID(), name: category, iconName: iconName)]
            let data = try? JSONEncoder().encode(categories)
            try? data?.write(to: categoryUrl)
            items = categories
        } else {
            fatalError("Something went really wrong")
        }
    }
}

private extension CategoriesViewModel {
    func loadExistingCategories() -> [TTCategory]? {
        return fileManager.loadCategories()
    }
}
