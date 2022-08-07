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
        if let schedules = viewModel.schedules, !schedules.isEmpty {
            Text("You have \(schedules.count) schedules")
        } else {
            emptyView
        }
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
                scheduleName: "July 2021",
                startDate: Date.create(day: 1, month: 7, year: 2021)!,
                endDate: Date.create(day: 31, month: 7, year: 2021)!
            ),
            SchedulingModel.Schedule(
                scheduleName: "August 2021",
                startDate: Date.create(day: 1, month: 8, year: 2021)!,
                endDate: Date.create(day: 31, month: 8, year: 2021)!
            )
        ]
        schedules = isEmpty ? nil : mockSchedules
    }
}
#endif
