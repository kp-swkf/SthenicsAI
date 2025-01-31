import SwiftUI
import FirebaseAuth

@MainActor
final class LoginPageViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailErrorMessage: String = ""
    @Published var passwordErrorMessage: String = "" // ✅ New error message for password
    @Published var isLoading: Bool = false
    @Published var isAuthenticated: Bool = false

    private let authenticationManager = AuthenticationManager.shared

    func login() async {
        isLoading = true
        emailErrorMessage = ""
        passwordErrorMessage = ""

        do {
            let authResult = try await authenticationManager.login(email: email, password: password)
            isAuthenticated = true // ✅ User successfully logged in
            print("Login successful: \(authResult.uid)")
        } catch {
            handleAuthError(error)
        }
        isLoading = false
    }

    private func handleAuthError(_ error: Error) {
        let errorMessage = error.localizedDescription.lowercased()

        if errorMessage.contains("password") {
            passwordErrorMessage = "Invalid password. Please try again." // ✅ Specific password error
        } else if errorMessage.contains("email") {
            emailErrorMessage = "Invalid email address. Please check your input." // ✅ Specific email error
        } else {
            emailErrorMessage = "Authentication failed. Please check your credentials."
        }
    }
}
