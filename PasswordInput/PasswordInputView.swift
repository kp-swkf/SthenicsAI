import SwiftUI

struct PasswordInputView: View {
    @Binding var password: String
    @Binding var errorMessage: String
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }

                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .modifier(InputFieldModifier(icon: "lock"))
            .onChange(of: password) { newValue in
                validatePassword(newValue)
            }
        }
    }

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
