//
//  CategoriesView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SwiftUI

struct CategoriesView: View {
    private let viewModel: Categories
    @State private var shouldCreateNewCategory = false
    
    init(viewModel: Categories) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("categories_title")
                    .font(.title)
                    .fontWeight(.bold)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .padding(.top, -10)
            }
            .padding(.bottom, 10)
            
            if shouldCreateNewCategory {
                Text("Create an activity")
            } else if let categories = viewModel.items, !categories.isEmpty {
                Text("You have \(categories.count) activities")
            } else {
                EmptyView(title: "categories_empty_list", iconName: "cloud.bolt.rain")
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem {
                if shouldCreateNewCategory {
                    Button("Save activity") {
                        shouldCreateNewCategory = false
                        print("Activity is being saved")
                    }
                } else {
                    Button("categories_add_category_cta") {
                        shouldCreateNewCategory = true
                    }
                }
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(viewModel: CategoriesViewModel())
    }
}
