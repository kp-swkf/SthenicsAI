import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var errorMessage: String = ""
    @State private var infoMessage: String = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
            
            Button("Reset Password") {
                AuthenticationManager.shared.resetPassword(for: email) { result in
                    switch result {
                    case .success:
                        // Show a success message, e.g.:
                        infoMessage = "Password reset email has been sent."
                    case .failure(let error):
                        // Present or log the error:
                        errorMessage = error.localizedDescription
                    }
                }
            }
            .padding()

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundStyle(.primary)
            }

            if !infoMessage.isEmpty {
                Text(infoMessage)
                    .foregroundStyle(.blue)
            }
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordView()
}
