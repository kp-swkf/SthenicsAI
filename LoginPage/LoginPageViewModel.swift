import SwiftUI
import SwiftfulRouting
import FirebaseAuth

@MainActor
final class LoginPageViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailErrorMessage: String = ""
    @Published var passwordErrorMessage: String = "" // ✅ New error message for password
    @Published var isLoading: Bool = false
    @Published var isAuthenticated: Bool = false
    
    init() {
        checkUserSession()
    }

    private let authenticationManager = AuthenticationManager.shared

    func login(router: Router) async {
        isLoading = true
        do {
            let authResult = try await authenticationManager.login(email: email, password: password)
            isAuthenticated = true
            print("Login successful: \(authResult.uid)")
            router.enterScreenFlow([AnyRoute(.fullScreenCover) { _ in HomePageView() }])
            
        } catch {
            handleAuthError(error)
        }
        isLoading = false
    }
    
    func checkUserSession() {
        if Auth.auth().currentUser != nil {
            isAuthenticated = true
        }
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
