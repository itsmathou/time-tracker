//
//  EmptyView.swift
//  TimeTracker
//

import SwiftUI

public struct EmptyView: View {
    let title: String.LocalizationValue
    let iconName: String
    
    public init(
        title: String.LocalizationValue,
        iconName: String
    ) {
        self.title = title
        self.iconName = iconName
    }
    
    public var body: some View {
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
