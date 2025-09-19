import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Card Model
struct Card: Identifiable {
    let id = UUID()
    let title: String
    let country: String
    let imageName: String
    let angle: Double
}

// MARK: - Main ContentView
struct ContentView: View {
    let cards: [Card] = [
        Card(title: "The Sounds of Nature", country: "Belgium", imageName: "nature", angle: -8),
        Card(title: "Heart of Norway's Majestic Forests", country: "Norway", imageName: "norway", angle: 6),
        Card(title: "Explore Austria's Alps", country: "Austria", imageName: "austria", angle: -4),
        Card(title: "Mystic Himalayas", country: "India", imageName: "himalayas", angle: 5)
    ]
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            CardStackView(cards: cards)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 60)
        }
    }
}

// MARK: - Card Stack
struct CardStackView: View {
    let cards: [Card]
    let cardWidth: CGFloat = 340
    let cardHeight: CGFloat = 220
    
    @State private var didAppear = false
    
    var body: some View {
        ZStack {
            ForEach(cards.indices, id: \.self) { index in
                let card = cards[index]
                
                CardView(card: card, width: cardWidth, height: cardHeight)
                    .rotationEffect(.degrees(card.angle))
                    .rotation3DEffect(.degrees(card.angle / 6), axis: (x: 1, y: 0, z: 0))
                    .offset(x: CGFloat(index) * 18 - (didAppear ? 0 : 30),
                            y: CGFloat(index) * 12 + (didAppear ? 0 : 30))
                    .zIndex(Double(cards.count - index))
                    .animation(.easeOut(duration: 0.45).delay(Double(index) * 0.06),
                               value: didAppear)
            }
        }
        .onAppear {
            didAppear = true
        }
    }
}

// MARK: - Individual Card
struct CardView: View {
    let card: Card
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background image
            Group {
                #if canImport(UIKit)
                if let ui = UIImage(named: card.imageName) {
                    Image(uiImage: ui)
                        .resizable()
                        .scaledToFill()
                } else {
                    ZStack {
                        Color(.secondarySystemFill)
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .opacity(0.25)
                    }
                }
                #else
                Image(card.imageName)
                    .resizable()
                    .scaledToFill()
                #endif
            }
            .frame(width: width, height: height)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 8)
            
            // Gradient overlay
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.55), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .center
                    )
                )
                .frame(width: width, height: height)
                .blendMode(.overlay)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                .allowsHitTesting(false)
            
            // Text
            VStack(alignment: .leading, spacing: 4) {
                Text(card.country.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.9))
                Text(card.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)
            }
            .padding(16)
            .frame(width: width, alignment: .leading)
        }
        .frame(width: width, height: height)
    }
}

// MARK: - Preview (this makes it show in Canvas)
#Preview {
    ContentView()
}
