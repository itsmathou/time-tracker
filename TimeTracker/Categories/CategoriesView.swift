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
    @State private var categoryName = ""
    
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
                createCategoriesView
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
                    Button("categories_save_category_cta") {
                        guard !categoryName.isEmpty else {
                            return
                        }
                        viewModel.save(category: categoryName)
                        shouldCreateNewCategory = false
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

private extension CategoriesView {
    var createCategoriesView: some View {
        TextField("categories_textfield_placeholder", text: $categoryName)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(viewModel: CategoriesViewModel())
    }
}
