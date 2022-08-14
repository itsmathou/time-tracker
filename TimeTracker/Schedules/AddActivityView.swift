//
//  AddActivityView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 13/08/2022.
//

import SwiftUI

struct AddActivityView: View {
    let categories: [Category]
    @Binding var selectedCategory: Category?
    @Binding var date: Date
    @Binding var isPresented: Bool

    var body: some View {
        VStack(alignment: .leading) {
            DatePicker(
                selection: $date,
                displayedComponents: .date
            ) {
                HStack {
                    Image(systemName: "clock")
                        .symbolRenderingMode(.hierarchical)
                    
                    Text("Date")
                }
            }
            .pickerStyle(.menu)
            
            Picker(selection: $selectedCategory) {
                ForEach(categories) { category in
                    /*@START_MENU_TOKEN@*/Text(category.name)/*@END_MENU_TOKEN@*/
                }
            } label: {
                HStack {
                    Image(systemName: "folder.fill")
                    Text("Category")
                }
            }
            
            Button {
                isPresented.toggle()
            } label: {
                Text("Save")
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
            selectedCategory: .constant(.stubReadingCategory),
            date: .constant(Date.create(day: 01, month: 07, year: 2022)!),
            isPresented: .constant(true)
        )
    }
}

#if DEBUG
extension Category {
    static let stubReadingCategory: Self = .init(
        id: UUID(),
        name: "Bookclub",
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
