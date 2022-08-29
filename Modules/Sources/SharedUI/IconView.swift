//
//  IconView.swift
//  TimeTracker
//

import SwiftUI

public struct IconView: View {
    let iconName: String
    
    public init(_ iconName: String) {
        self.iconName = iconName
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray.opacity(0.5))
                .frame(width: 30, height: 30)
            
            Image(systemName: iconName)
        }
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView("heart")
    }
}
