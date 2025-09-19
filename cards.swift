import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let title: String
    let country: String
    let image: String   // name of the image in Assets
    let angle: Double
}

struct CardStackView: View {
    
    let cards: [Card] = [
        Card(title: "The Sounds of Nature", country: "Belgium", image: "nature", angle: -8),
        Card(title: "Heart of Norway's Majestic Forests", country: "Norway", image: "norway", angle: 5),
        Card(title: "Explore Austria's Alps", country: "Austria", image: "austria", angle: -4)
    ]
    
    var body: some View {
        ZStack {
            ForEach(cards.indices, id: \.self) { index in
                CardView(card: cards[index])
                    .rotationEffect(.degrees(cards[index].angle))
                    .offset(x: CGFloat(index) * 20,
                            y: CGFloat(index) * 15)
                    .zIndex(Double(cards.count - index))
            }
        }
        .padding()
    }
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background image
            Image(card.image)
                .resizable()
                .scaledToFill()
                .frame(width: 320, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .shadow(radius: 8)
            
            // Overlay for text readability
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            // Text
            VStack(alignment: .leading) {
                Text(card.country.uppercased())
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white.opacity(0.9))
                Text(card.title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(width: 320, height: 200)
    }
}

struct ContentView: View {
    var body: some View {
        CardStackView()
    }
}
