//
//  ScheduleItemView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 14/08/2022.
//

import SwiftUI

struct ScheduleItemView: View {
    let schedule: Schedule
    
    @StateObject var viewModel: SchedulesViewModel
    @State var addActivityIsPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(schedule.scheduleName)
                .padding(.bottom, 5)
            
            Text("schedules_schedule_date_range \(schedule.startDate.formatted(date: .long, time: .omitted)) \(schedule.endDate.formatted(date: .long, time: .omitted))")
                .padding(.bottom, 5)
            
            VStack(alignment: .leading) {
                let activityList = schedule.getActivitiesByCategory()
                if !schedule.activities.isEmpty {
                    ForEach(activityList) { activity in
                        VStack(alignment: .leading) {
                            HStack {
                                IconView("heart.fill")
                                
                                Text(activity.categoryName)
                                    .font(.title2)
                            }
                            
                            ForEach(activity.activities) { item in
                                Text(item.date.formatted(date: .complete, time: .omitted))
                                    .font(.body)
                                    .padding(.bottom, 2)
                                    .padding(.leading, 20)
                            }
                        }
                        .padding(.bottom, 5)
                    }
                }
                
                Button {
                    addActivityIsPresented.toggle()
                } label: {
                    Text("schedules_add_activity_cta")
                }
                .popover(
                    isPresented: $addActivityIsPresented
                ) {
                    AddActivityView(
                        categories: viewModel.categories,
                        schedule: schedule,
                        selectedCategory: $viewModel.selectedCategory,
                        date: $viewModel.activityDate,
                        isPresented: $addActivityIsPresented,
                        saveActivity: viewModel.handle
                    )
                    .padding()
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3))
        }
    }
}

struct ScheduleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleItemView(
            schedule: .firstStubSchedule,
            viewModel: SchedulesViewModel(
                fileManager: MockFileManager(
                    schedules: [.firstStubSchedule]
                )
            )
        )
    }
}
