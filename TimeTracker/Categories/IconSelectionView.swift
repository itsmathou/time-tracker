//
//  IconSelectionView.swift
//  TimeTracker
//
//  Created by Mathilde Ferrand on 13/08/2022.
//

import SwiftUI

struct IconSelectionView: View {
    @State var selectedIconName: String = ""

    let iconNames = [
        "heart.fill", "globe.europe.africa.fill", "leaf.fill", "pawprint.fill",
        "pencil", "gamecontroller.fill", "pc", "headphones", "sparkles.tv.fill",
        "airplane", "bicycle", "figure.walk", "play.rectangle.fill", "bag.fill",
        "book.closed"
    ]
    
    let columns = [
        GridItem(.flexible(minimum: 30)),
        GridItem(.flexible(minimum: 30)),
        GridItem(.flexible(minimum: 30))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(iconNames, id: \.self) { iconName in
                Image(systemName: iconName)
                    .padding(3)
                    .background(
                        selectedIconName == iconName ?
                        Color.gray.opacity(0.3) :
                                .clear
                    )
                    .cornerRadius(3)
                    .onTapGesture {
                        selectedIconName = iconName
                    }
            }
        }
    }
}

struct IconSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectionView()
    }
}
