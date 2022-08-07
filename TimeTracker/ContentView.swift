//
//  ContentView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    SchedulingView(viewModel: SchedulingViewModel())
                } label: {
                    Image(systemName: "calendar")
                    
                    Text("scheduling_title")
                }
            }
        }
        .navigationTitle("app_title")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
