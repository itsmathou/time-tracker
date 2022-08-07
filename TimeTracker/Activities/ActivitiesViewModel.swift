//
//  ActivitiesViewModel.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import Foundation

protocol Activities {
    var items: [Activities]? { get }
}


final class ActivitiesViewModel: Activities {
    let items: [Activities]?
    
    init() {
        items = [Activities]()
    }
    
}
