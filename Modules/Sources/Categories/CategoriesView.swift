//
//  CategoriesView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SharedUI
import SwiftUI

public struct CategoriesView: View {
    @ObservedObject private var viewModel: CategoriesViewModel
    @State private var shouldCreateNewCategory = false
    @State private var shouldShowIconSelection = false
    @State private var categoryName = ""
    @State private var iconName = "heart.fill"
    
    public init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
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
                ForEach(categories) { category in
                    HStack {
                        IconView(category.iconName)
                        
                        Text(category.name)
                            .font(.body)
                    }
                }
            } else {
                HStack {
                    Spacer()
                    
                    EmptyView(title: "categories_empty_list", iconName: "folder.badge.questionmark")
                    
                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem {
                if shouldCreateNewCategory {
                    HStack {
                        Button("categories_save_category_cta") {
                            guard !categoryName.isEmpty else {
                                return
                            }
                            viewModel.save(category: categoryName, iconName: iconName)
                            shouldCreateNewCategory = false
                        }
                        
                        Button("categories_cancel_cta") {
                            shouldCreateNewCategory = false
                        }
                    }
                } else {
                    Button {
                        shouldCreateNewCategory = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

private extension CategoriesView {
    var createCategoriesView: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("categories_textfield_placeholder", text: $categoryName)
            
            HStack {
                Button {
                    shouldShowIconSelection = true
                } label: {
                    Text("categories_pick_icon_cta")
                }
                .buttonStyle(.borderless)
                .popover(isPresented: $shouldShowIconSelection) {
                    IconSelectionView(
                        selectedIconName: $iconName,
                        shouldBeDismissed: $shouldShowIconSelection
                    )
                    .padding()
                }
                
                IconView(iconName)
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(viewModel: CategoriesViewModel())
    }
}
