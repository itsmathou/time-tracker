//
//  CategoriesViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

protocol Categories {
    var items: [Category]? { get }
}


final class CategoriesViewModel: Categories {
    let items: [Category]?
    
    init() {
        items = [Category]()
    }
    
}
