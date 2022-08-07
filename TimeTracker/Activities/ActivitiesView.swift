//
//  ActivitiesView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SwiftUI

struct ActivitiesView: View {
    private let viewModel: Activities
    @State private var shouldCreateNewActivity = false
    
    init(viewModel: Activities) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("activities_title")
                    .font(.title)
                    .fontWeight(.bold)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .padding(.top, -10)
            }
            .padding(.bottom, 10)
            
            if shouldCreateNewActivity {
                Text("Create an activity")
            } else if let activities = viewModel.items, !activities.isEmpty {
                Text("You have \(activities.count) activities")
            } else {
                EmptyView(title: "activities_empty_list", iconName: "cloud.bolt.rain")
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem {
                if shouldCreateNewActivity {
                    Button("Save activity") {
                        shouldCreateNewActivity = false
                        print("Activity is being saved")
                    }
                } else {
                    Button("activities_add_activity_cta") {
                        shouldCreateNewActivity = true
                    }
                }
            }
        }
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView(viewModel: ActivitiesViewModel())
    }
}
