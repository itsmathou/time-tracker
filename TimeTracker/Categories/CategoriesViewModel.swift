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
    let items: [Category]?
    
    init(fileManager: FileManagement = TTFileManager()) {
        self.fileManager = fileManager
        items = [Category]()
    }
    
    func save(category: String) {
        print("category is being saved")
    }
}
