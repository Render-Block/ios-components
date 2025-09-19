import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let dataString: String

    var body: some View {
        Image(uiImage: generateQRCode(from: dataString))
            .interpolation(.none)
            .resizable()
            .frame(width: 200, height: 200)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5)
    }

    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")

        guard let outputImage = filter.outputImage else {
            return UIImage(systemName: "xmark.octagon.fill") ?? UIImage()
        }

        // Scale the QR code
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledImage = outputImage.transformed(by: transform)

        let context = CIContext()
        if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return UIImage(systemName: "xmark.octagon.fill") ?? UIImage()
    }
}

struct ContentView: View {
    @State private var textToEncode: String = "https://example.com"

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter text or URL", text: $textToEncode)
                .textFieldStyle(.roundedBorder)
                .padding()

            QRCodeView(dataString: textToEncode)

            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
