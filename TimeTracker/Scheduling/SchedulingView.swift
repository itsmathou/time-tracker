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
            Text("scheduling_title")
                .font(.title)
            
            Text("scheduling_description")
            
            HStack {
                DatePicker(selection: $startDate, displayedComponents: .date) {
                    Text("scheduling_start")
                        .font(.body)
                }
                
                DatePicker(selection: $endDate, in: startDate..., displayedComponents: .date) {
                    Text("scheduling_end")
                        .font(.body)
                }
            }
            
            Text("scheduling_summary \(startDate.formatted(date: .long, time: .omitted)) \(endDate.formatted(date: .long, time: .omitted))")
                .font(.body)
            
            HStack {
                
                Spacer()
                
                Button(action: {}) {
                    Text("scheduling_save_cta")
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
