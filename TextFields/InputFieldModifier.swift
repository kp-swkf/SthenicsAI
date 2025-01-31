
import SwiftUI

struct InputFieldModifier: ViewModifier {
    @FocusState private var isFocused: Bool
    let icon: String

    func body(content: Content) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isFocused ? .blue : .gray)

            content
                .focused($isFocused)

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isFocused ? Color.blue : Color.clear, lineWidth: 1)
                )
        )
    }
}
