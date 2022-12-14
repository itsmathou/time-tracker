import SwiftUI

struct IconSelectionView: View {
    @Binding var selectedIconName: String
    @Binding var shouldBeDismissed: Bool

    let iconNames = [
        "heart.fill", "globe.europe.africa.fill", "leaf.fill", "pawprint.fill",
        "pencil", "gamecontroller.fill", "pc", "headphones", "sparkles.tv.fill",
        "airplane", "bicycle", "figure.walk", "play.rectangle.fill", "bag.fill",
        "books.vertical.fill", "building.fill", "ticket.fill", "suitcase.fill"
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
                        shouldBeDismissed.toggle()
                    }
            }
        }
    }
}

struct IconSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectionView(
            selectedIconName: .constant("heart.fill"),
            shouldBeDismissed: .constant(false)
        )
    }
}
