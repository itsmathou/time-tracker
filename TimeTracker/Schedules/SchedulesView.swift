//
//  Schedules.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SwiftUI

struct SchedulesView: View {
    @State private var shouldCreateNewSchedule = false
    @State private var shouldShowMissingNameAlert = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var scheduleName = ""
    private let viewModel: Schedules
    
    init(viewModel: Schedules) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("schedules_title")
                    .font(.title)
                    .fontWeight(.bold)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .padding(.top, -10)
            }
            .padding(.bottom, 10)
            
            if shouldCreateNewSchedule {
                VStack(alignment: .leading) {
                    Group {
                        Text("scheduling_title")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3))
                            .padding(.top, -10)
                    }
                    .padding(.bottom, 10)
                    
                    Text("scheduling_description")
                        .padding(.bottom, 5)
                    
                    TextField("scheduling_name_placeholder", text: $scheduleName)
                        .padding(.bottom, 5)
                    
                    HStack(spacing: 30) {
                        DatePicker(selection: $startDate, displayedComponents: .date) {
                            Text("scheduling_start")
                                .font(.body)
                        }
                        
                        DatePicker(selection: $endDate, in: startDate..., displayedComponents: .date) {
                            Text("scheduling_end")
                                .font(.body)
                        }
                    }
                    .padding(.bottom, 10)
                    
                    Text("scheduling_summary \(startDate.formatted(date: .long, time: .omitted)) \(endDate.formatted(date: .long, time: .omitted))")
                        .font(.body)
                        .padding(.bottom, 10)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            saveSchedule()
                        } label: {
                            Text("scheduling_save_cta")
                        }

                    }
                    
                    Spacer()
                }
            } else if let schedules = viewModel.schedules, !schedules.isEmpty {
                List(schedules) { schedule in
                    VStack(alignment: .leading) {
                        Text(schedule.scheduleName)
                            .padding(.bottom, 5)
                        
                        Text("schedules_schedule_date_range \(schedule.startDate.formatted(date: .long, time: .omitted)) \(schedule.endDate.formatted(date: .long, time: .omitted))")
                            .padding(.bottom, 5)
                        
                        Button {
                            addActivityTapped()
                        } label: {
                            Text("schedules_add_activity_cta")
                        }
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3))
                    }
                    .padding(.bottom, 30)
                }
            } else {
                EmptyView(title: "schedules_empty_list", iconName: "cloud.bolt.rain")
                
                Spacer()
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem {
                if shouldCreateNewSchedule {
                    Button("schedules_save_cta") {
                        saveSchedule()
                        shouldCreateNewSchedule = false
                    }
                } else {
                    Button("schedules_add_cta") {
                        shouldCreateNewSchedule = true
                    }
                }
            }
        }
    }
}

private extension SchedulesView {    
    func addActivityTapped() {
        print("Activity button tapped")
    }
    
    func saveSchedule() {
        guard !scheduleName.isEmpty else {
            shouldShowMissingNameAlert = true
            return
        }
        viewModel.save(
            schedule: .init(
                id: UUID(),
                scheduleName: scheduleName,
                startDate: startDate,
                endDate: endDate
            )
        )
    }
}

struct SchedulesView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesView(viewModel: MockSchedulesViewModel(isEmpty: true))
    }
}

#if DEBUG
final class MockSchedulesViewModel: Schedules {
    var schedules: [SchedulingModel.Schedule]?
    
    init(isEmpty: Bool) {
        let mockSchedules = [
            SchedulingModel.Schedule(
                id: UUID(),
                scheduleName: "July 2021",
                startDate: Date.create(day: 1, month: 7, year: 2021)!,
                endDate: Date.create(day: 31, month: 7, year: 2021)!
            ),
            SchedulingModel.Schedule(
                id: UUID(),
                scheduleName: "August 2021",
                startDate: Date.create(day: 1, month: 8, year: 2021)!,
                endDate: Date.create(day: 31, month: 8, year: 2021)!
            )
        ]
        schedules = isEmpty ? nil : mockSchedules
    }
    
    func save(schedule: SchedulingModel.Schedule) {}
}
#endif
