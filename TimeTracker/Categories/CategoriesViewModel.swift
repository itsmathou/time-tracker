//
//  CategoriesViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

protocol Categories {
    var items: [Category]? { get }
    func save(category: String)
}


final class CategoriesViewModel: Categories {
    private let fileManager: FileManagement
    var items: [Category]?
    
    init(fileManager: FileManagement = TTFileManager()) {
        self.fileManager = fileManager
        items = loadExistingCategories()
    }
    
    func save(category: String) {
        if let existingCategories = loadExistingCategories(),
           let categoriesUrl = fileManager.documentUrl(for: .categories) {
            var newListOfCategories = existingCategories
            newListOfCategories.append(Category(id: UUID(), name: category))
            let data = try? JSONEncoder().encode(newListOfCategories)
            try? data?.write(to: categoriesUrl)
        } else if let categoryUrl = fileManager.documentUrl(for: .categories) {
            let categories = [Category(id: UUID(), name: category)]
            let data = try? JSONEncoder().encode(categories)
            try? data?.write(to: categoryUrl)
        } else {
            fatalError("Something went really wrong")
        }
    }
}

private extension CategoriesViewModel {
    func loadExistingCategories() -> [Category]? {
        return fileManager.loadCategories()
    }
}
