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
                
                Button(action: {}) {
                    Text("scheduling_save_cta")
                }
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
    }
}

struct SchedulingView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulingView()
    }
}
