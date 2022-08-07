//
//  Schedules.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SwiftUI

struct SchedulesView: View {
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

            if let schedules = viewModel.schedules, !schedules.isEmpty {
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
                emptyView
            }
        }
        .padding(.horizontal, 20)
    }
}

private extension SchedulesView {
    var emptyView: some View {
        HStack {
            Image(systemName: "cloud.bolt.rain")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .teal, .white)
                .font(.body)
            
            Text("schedules_empty_list")
                .font(.body)
        }
    }
    
    func addActivityTapped() {
        print("Activity button tapped")
    }
}

struct SchedulesView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesView(viewModel: MockSchedulesViewModel(isEmpty: false))
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
}
#endif
