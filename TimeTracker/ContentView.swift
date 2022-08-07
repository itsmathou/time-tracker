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
                    SchedulingView()
                } label: {
                    Image(systemName: "calendar")
                    
                    Text("Create schedule")
                }
            }
        }
        .navigationTitle("Time Tracker")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
