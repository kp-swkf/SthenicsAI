import Foundation

struct PasswordInputModel {
    let password: String

    /// Validates the password against defined rules.
    func validate() -> PasswordValidationResult {
        let rules: [(String, (String) -> Bool)] = [
            ("Please enter your password.", { !$0.isEmpty }),
            ("Password must be at least 8 characters.", { $0.count >= 8 }),
            ("Password must contain at least one uppercase letter.", containsUppercase),
            ("Password must contain at least one lowercase letter.", containsLowercase),
            ("Password must contain at least one digit.", containsDigit),
            ("Password must contain at least one special character.", containsSpecialCharacter)
        ]
        
        for (errorMessage, rule) in rules {
            if !rule(password) {
                return .failure(errorMessage)
            }
        }
        
        return .success
    }

    /// Helper functions for specific password rules
    private func containsUppercase(_ text: String) -> Bool {
        return text.range(of: "[A-Z]", options: .regularExpression) != nil
    }

    private func containsLowercase(_ text: String) -> Bool {
        return text.range(of: "[a-z]", options: .regularExpression) != nil
    }

    private func containsDigit(_ text: String) -> Bool {
        return text.range(of: "\\d", options: .regularExpression) != nil
    }

    private func containsSpecialCharacter(_ text: String) -> Bool {
        return text.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil
    }
}

/// Enum for password validation results
enum PasswordValidationResult {
    case success
    case failure(String)
}
