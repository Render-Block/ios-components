import SwiftUI

struct RectangleProgressBar: View {
    var progress: Double // 0.0 to 1.0
    var barHeight: CGFloat = 20
    var barColor: Color = .blue
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Background track
            RoundedRectangle(cornerRadius: barHeight / 2)
                .fill(Color.gray.opacity(0.2))
                .frame(height: barHeight)
            
            // Progress fill
            RoundedRectangle(cornerRadius: barHeight / 2)
                .fill(barColor)
                .frame(width: CGFloat(progress) * 300, height: barHeight) // 300 = bar width
                .animation(.easeInOut(duration: 0.5), value: progress)
        }
        .frame(width: 300, height: barHeight) // fixed width for demo
    }
}

struct ContentView: View {
    @State private var progress: Double = 0.35
    
    var body: some View {
        VStack(spacing: 40) {
            RectangleProgressBar(progress: progress, barColor: .green)
            
            Button("Increase Progress") {
                withAnimation {
                    progress = min(progress + 0.1, 1.0)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
