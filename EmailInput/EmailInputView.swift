import SwiftUI

struct EmailInputView: View {
    @Binding var email: String
    @Binding var errorMessage: String
    @FocusState private var isFocused: Bool  // Keeps track of focus state
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
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
                
                // ✅ Clear Button inside the HStack
                if !email.isEmpty {
                    Button(action: {
                        email = ""
                        errorMessage = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8) // Add space to the right
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
