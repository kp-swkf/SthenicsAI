import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    @Binding var errorMessage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Placeholder and TextField
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                TextField("", text: $text)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .foregroundColor(.black)
                    .font(.headline)
            }

            // Error Message
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

extension View {
    func customBackground() -> some View {
            ZStack {
                Color.blue.opacity(0.8)
                    .ignoresSafeArea()
                
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                    .ignoresSafeArea()
                
                self
            }
    }
}

#Preview {
    // Using @State to simulate bindings in previews
    @Previewable @State var text: String = ""
    @Previewable @State var errorMessage: String = "This field is required."
    
    return CustomTextField(
        placeholder: "Enter your name",
        text: $text,
        errorMessage: $errorMessage
    )
}
