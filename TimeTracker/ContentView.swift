//
//  ContentView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var item: Item? = .mySchedules

    var body: some View {
        NavigationView {
            List {
                Section("sidebar_section_first") {
                    NavigationLink(tag: Item.mySchedules, selection: $item) {
                        SchedulesView(viewModel: SchedulesViewModel())
                    } label: {
                        sidebarLabel("schedules_title", iconName: "calendar.badge.clock")
                    }
                    
                    NavigationLink(tag: Item.myCategories, selection: $item) {
                        CategoriesView(viewModel: CategoriesViewModel())
                    } label: {
                        sidebarLabel("categories_title", iconName: "guitars.fill")
                    }
                }
                .headerProminence(.increased)
            }
        }
        .navigationTitle("app_title")
    }
}

private extension ContentView {
    func sidebarLabel(_ title: String.LocalizationValue, iconName: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .red)
            
            Text(String(localized: title))
        }
        .padding(.leading, 5)
    }
    
    enum Item: Hashable, Identifiable {
        case mySchedules
        case myCategories
        
        var id: Item { self }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
