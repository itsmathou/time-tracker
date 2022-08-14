//
//  IconView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 14/08/2022.
//

import SwiftUI

struct IconView: View {
    let iconName: String
    
    init(_ iconName: String) {
        self.iconName = iconName
    }
    
    var body: some View {
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
