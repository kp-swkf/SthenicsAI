import SwiftUI

struct PasswordInputView: View {
    @Binding var password: String
    @Binding var errorMessage: String
    @FocusState private var isFocused: Bool
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack {
            HStack {
                // Lock Icon
                Image(systemName: "lock")
                    .foregroundColor(isFocused ? .blue : .gray)
                
                // Password Input Field
                if isPasswordVisible {
                    TextField("Password", text: $password)
                        .focused($isFocused)
                } else {
                    SecureField("Password", text: $password)
                        .focused($isFocused)
                }
                
                // Show/Hide Password Button
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
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
            .padding(.horizontal)
            
            // Error Message
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }
        }
        .onChange(of: password) { newValue in
            validatePassword(newValue)
        }
    }

    // Password Validation Using ValidationManager
    private func validatePassword(_ password: String) {
        let validation = ValidationManager.validatePassword(password)
        switch validation {
        case .success:
            errorMessage = ""
        case .failure(let message):
            errorMessage = message
        }
    }
}

#Preview {
    @State var password = ""
    @State var errorMessage = ""

    PasswordInputView(password: $password, errorMessage: $errorMessage)
}
