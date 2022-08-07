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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("This is where can create your schedule")
                .font(.title)
            
            HStack {
                DatePicker(selection: $startDate, displayedComponents: .date) {
                    Text("Start date")
                        .font(.body)
                }
                
                DatePicker(selection: $endDate, in: startDate..., displayedComponents: .date) {
                    Text("End date")
                        .font(.body)
                }
            }
            
            Text("Your schedule will start on \(startDate.formatted(date: .long, time: .omitted)) and end on \(endDate.formatted(date: .long, time: .omitted))")
                .font(.body)
            
            HStack {
                
                Spacer()
                
                Button(action: {}) {
                    Text("Save my schedule")
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct SchedulingView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulingView()
    }
}
