import Foundation

struct Validator {
    static func validateEmail(_ email: String) -> ValidationResult {
        if email.isEmpty {
            return .failure("Please enter your email address.")
        } else if !email.contains("@") {
            return .failure("Please enter a valid email address.")
        }
        
        return .success("Email is valid.")
    }
}

enum ValidationResult {
    case success(String) // Contains a success message
    case failure(String) // Contains an error message
}
