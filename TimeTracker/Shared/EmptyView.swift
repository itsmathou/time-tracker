//
//  EmptyView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 07/08/2022.
//

import SwiftUI

struct EmptyView: View {
    let title: String.LocalizationValue
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .teal, .white)
                .font(.body)
            
            Text(String(localized: title))
                .font(.body)
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(title: "activities_empty_list", iconName: "cloud.bolt.rain")
    }
}
