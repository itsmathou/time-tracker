//
//  ActivitiesView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SwiftUI

struct ActivitiesView: View {
    private let viewModel: Activities
    
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
            
            if let activities = viewModel.items, !activities.isEmpty {
                Text("You have \(activities.count) activities")
            } else {
                EmptyView(title: "activities_empty_list", iconName: "cloud.bolt.rain")
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView(viewModel: ActivitiesViewModel())
    }
}
