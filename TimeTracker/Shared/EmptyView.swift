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
        VStack {
            Image(systemName: iconName)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .teal, .white)
                .padding(.bottom, 10)
                .font(.title)
            
            Text(String(localized: title))
                .font(.body)
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(title: "categories_empty_list", iconName: "folder.badge.questionmark")
    }
}
