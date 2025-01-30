import SwiftUI

struct EmailInputView: View {
    @Binding var email: String
    @Binding var errorMessage: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Email Input Field
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(isFocused ? .blue : .gray)

                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($isFocused)
                    .onChange(of: email) { newValue in
                        validateEmail(newValue)
                    }

                if !email.isEmpty {
                    Button(action: {
                        email = ""
                        errorMessage = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }

            // Error Message
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    private func validateEmail(_ email: String) {
        let validation = ValidationManager.validateEmail(email)
        switch validation {
        case .success:
            errorMessage = ""
        case .failure(let message):
            errorMessage = message
        }
    }
}

