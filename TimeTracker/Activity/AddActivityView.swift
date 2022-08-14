//
//  AddActivityView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 13/08/2022.
//

import SwiftUI

struct AddActivityView: View {
    let categories: [Category]
    let schedule: Schedule
    @Binding var selectedCategory: Category?
    @Binding var date: Date
    @Binding var isPresented: Bool
    var saveActivity: (ScheduleEvent) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            DatePicker(
                selection: $date,
                displayedComponents: .date
            ) {
                HStack {
                    Image(systemName: "clock")
                        .symbolRenderingMode(.hierarchical)
                    
                    Text("add_activity_date")
                }
            }
            
            Picker(selection: $selectedCategory) {
                ForEach(categories) { category in
                    Text(category.name)
                        .tag(Optional(category))
                }
            } label: {
                HStack {
                    Image(systemName: "folder.fill")
                    
                    Text("add_activity_category")
                }
            }
            
            Button {
                isPresented.toggle()
                saveActivity(.saveActivity(.init(id: UUID(), date: date, category: selectedCategory!), schedule))
            } label: {
                Text("add_activity_save_cta")
            }
            
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(
            categories: [
                .stubGamingCategory,
                .stubOfficeCategory,
                .stubReadingCategory
            ],
            schedule: .firstStubSchedule,
            selectedCategory: .constant(.stubReadingCategory),
            date: .constant(Date.create(day: 01, month: 07, year: 2022)!),
            isPresented: .constant(true),
            saveActivity: { _ in }
        )
    }
}

#if DEBUG
extension Category {
    static let stubReadingCategory: Self = .init(
        id: UUID(),
        name: "Book Club",
        iconName: "books.vertical.fill"
    )
    
    static let stubGamingCategory: Self = .init(
        id: UUID(),
        name: "Video Games",
        iconName: "gamecontroller.fill"
    )
    
    static let stubOfficeCategory: Self = .init(
        id: UUID(),
        name: "Office Attendance",
        iconName: "building.fill"
    )
}
#endif
