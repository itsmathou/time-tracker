//
//  SchedulingView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SwiftUI

struct SchedulingView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var scheduleName = ""
    @State private var shouldShowMissingNameAlert = false
    
    var body: some View {
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
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .alert(
            "scheduling_error_title",
            isPresented: $shouldShowMissingNameAlert,
            actions: {
                Button(role: .cancel, action: {}) {
                    Text("scheduling_error_cta")
                }
            }) {
                Text("scheduling_error_message")
            }
    }
}

private extension SchedulingView {
    func saveSchedule() {
        guard !scheduleName.isEmpty else {
            shouldShowMissingNameAlert = true
            return
        }
        print("Schedule name: \(scheduleName), startDate: \(startDate.formatted(date: .long, time: .omitted)), endDate: \(endDate.formatted(date: .long, time: .omitted))")
    }
}

struct SchedulingView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulingView()
    }
}
