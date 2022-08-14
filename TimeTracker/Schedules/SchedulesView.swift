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
    @State private var shouldShowDeletionConfirmation = false
    @State private var shouldShowAddActivity = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var scheduleName = ""
    @State private var selectedCategory: Category?
    @State private var activityDate = Date()
    @FocusState private var scheduleNameFieldIsFocused: Bool
    @ObservedObject private var viewModel: SchedulesViewModel
    
    init(viewModel: SchedulesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(shouldCreateNewSchedule ? "schedules_create_title" : "schedules_list_title")
                    .font(.title)
                    .fontWeight(.bold)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .padding(.top, -10)
            }
            .padding(.bottom, 10)
            
            if shouldCreateNewSchedule {
                createScheduleView

            } else if let schedules = viewModel.schedules, !schedules.isEmpty {
                listOfSchedules(schedules: schedules)

            } else {
                HStack {
                    Spacer()
                    
                    EmptyView(title: "schedules_empty_list", iconName: "calendar.badge.exclamationmark")
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem {
                if shouldCreateNewSchedule {
                    HStack {
                        Button("schedules_save_cta") {
                            saveSchedule()
                        }
                        
                        Button("schedules_cancel_cta") {
                            shouldCreateNewSchedule = false
                        }
                    }
                } else {
                    HStack {
                        Button {
                            shouldCreateNewSchedule = true
                        } label: {
                            Image(systemName: "plus")
                        }

                        
                        if !viewModel.selectedSchedules.isEmpty {
                            Button("schedules_delete_cta") {
                                shouldShowDeletionConfirmation = true
                            }
                        }
                    }
                }
            }
        }
    }
}

private extension SchedulesView {    
    func addActivityTapped() {
        shouldShowAddActivity = true
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
                endDate: endDate,
                activities: []
            )
        )
        shouldCreateNewSchedule = false
    }
    
    func deleteSchedules() {
        viewModel.deleteSchedules()
    }
    
    var createScheduleView: some View {
        VStack(alignment: .leading) {
            Text("schedules_create_description")
                .padding(.bottom, 5)
            
            TextField("schedules_create_name_placeholder", text: $scheduleName)
                .padding(.bottom, 5)
                .focused($scheduleNameFieldIsFocused)
            
            HStack(spacing: 30) {
                DatePicker(selection: $startDate, displayedComponents: .date) {
                    Text("schedules_create_start")
                        .font(.body)
                }
                
                DatePicker(selection: $endDate, in: startDate..., displayedComponents: .date) {
                    Text("schedules_create_end")
                        .font(.body)
                }
            }
            .padding(.bottom, 10)
            
            Text("schedules_create_summary \(startDate.formatted(date: .long, time: .omitted)) \(endDate.formatted(date: .long, time: .omitted))")
                .font(.body)
                .padding(.bottom, 10)
            
            Spacer()
        }
        .alert(
            "schedules_save_cta",
            isPresented: $shouldShowMissingNameAlert) {
                HStack {
                    Button(role: .cancel, action: {}) {
                        Text("schedules_error_cta")
                    }
                    
                    Button(role: .destructive) {
                        shouldCreateNewSchedule = false
                    } label: {
                        Text("schedules_error_discard_cta")
                    }
                }
            } message: {
                Text("schedules_error_message")
            }
        .onAppear {
            scheduleNameFieldIsFocused = true
        }

    }
    
    func listOfSchedules(schedules: [Schedule]) -> some View {
        List(schedules, id: \.self, selection: $viewModel.selectedSchedules) { schedule in
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
                .popover(
                    isPresented: $shouldShowAddActivity
                ) {
                    AddActivityView(
                        categories: viewModel.categories,
                        selectedCategory: $selectedCategory,
                        date: $activityDate,
                        isPresented: $shouldShowAddActivity
                    )
                    .padding()
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3))
            }
        }
        .alert("schedules_delete_alert_title", isPresented: $shouldShowDeletionConfirmation) {
            HStack {
                Button(role: .destructive, action: deleteSchedules) {
                    Text("schedules_delete_alert_confirmation_cta")
                }
                
                Button(role: .cancel, action: {}) {
                    Text("schedules_delete_alert_cancel_cta")
                }
            }
        } message: {
            Text("schedules_delete_alert_message \(viewModel.selectedSchedules.count.formatted(.number))")
        }
    }
}

struct SchedulesView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesView(viewModel: SchedulesViewModel(fileManager: MockFileManager(schedules: nil)))
    }
}
