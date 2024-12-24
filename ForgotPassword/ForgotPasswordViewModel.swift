import Foundation
import Combine

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var error: Error?
    
    private var cancellabes = Set<AnyCancellable>() //
    
    func submitforgotPassword() {
        guard validateEmail() else { return }
        
    }
    private func validateEmail() -> Bool {
        if email.isEmpty {
            print("Please provide your email")
            return false
        }
        return true
    }
    
    
}
