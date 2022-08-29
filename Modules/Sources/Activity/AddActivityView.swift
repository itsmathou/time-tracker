import FileManagement
import Models
import SwiftUI

public struct AddActivityView: View {
    let categories: [TTCategory]
    let schedule: Schedule
    @Binding var selectedCategory: TTCategory?
    @Binding var date: Date
    @Binding var isPresented: Bool
    var saveActivity: (ScheduleEvent) -> Void
    
    public init(
        categories: [TTCategory],
        schedule: Schedule,
        selectedCategory: Binding<TTCategory?>,
        date: Binding<Date>,
        isPresented: Binding<Bool>,
        saveActivity: @escaping (ScheduleEvent) -> Void
    ) {
        self.categories = categories
        self.schedule = schedule
        self._selectedCategory = selectedCategory
        self._date = date
        self._isPresented = isPresented
        self.saveActivity = saveActivity
    }

    public var body: some View {
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
extension TTCategory {
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
