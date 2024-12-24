import SwiftUI
import Combine

class PasswordInputViewModel: ObservableObject {
    @Published var password: String = ""
    @Published var isFocused: Bool = false
    @Published private(set) var isValid: Bool = false
    @Published private(set) var errorMessage: String = ""
    
    private var cancellables = Set<AnyCancellable>() // Persistent cancellables property
    
    init() {
        $password
            .sink { [weak self] newValue in
                self?.validatePassword(newValue)
            }
            .store(in: &cancellables) // Use the cancellables property
    }
    
    private func validatePassword(_ password: String) {
        let validators: [(String) -> ValidationResult] = [
            validateNotEmpty,
            validateLength,
            validateComplexity,
            validateSpecialCharacter,
            validateNotCommonPassword
        ]
        
        for validator in validators {
            let result = validator(password)
            switch result {
            case .failure(let message):
                isValid = false
                errorMessage = message
                return
            case .success:
                continue
            }
        }
        
        // If all validators pass
        isValid = true
        errorMessage = ""
    }
    
    // MARK: - Validation Rules
    
    private func validateNotEmpty(_ password: String) -> ValidationResult {
        if password.isEmpty {
            return .failure("Please enter your password.")
        }
        return .success
    }
    
    private func validateLength(_ password: String) -> ValidationResult {
        if password.count < 8 {
            return .failure("Password must be at least 8 characters.")
        }
        return .success
    }
    
    private func validateComplexity(_ password: String) -> ValidationResult {
        let containsUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let containsLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
        let containsDigit = password.range(of: "\\d", options: .regularExpression) != nil
        
        if !containsUppercase || !containsLowercase || !containsDigit {
            return .failure("Password must include uppercase, lowercase, and a number.")
        }
        return .success
    }
    
    private func validateSpecialCharacter(_ password: String) -> ValidationResult {
        let specialCharacterRegex = "[^A-Za-z0-9]"
        if password.range(of: specialCharacterRegex, options: .regularExpression) == nil {
            return .failure("Password must include at least one special character.")
        }
        return .success
    }
    
    private func validateNotCommonPassword(_ password: String) -> ValidationResult {
        let commonPasswords = ["password", "123456", "qwerty", "abc123", "letmein"]
        if commonPasswords.contains(password.lowercased()) {
            return .failure("Password is too common. Please choose a more secure password.")
        }
        return .success
    }
    
    // MARK: - ValidationResult Enum
    
    enum ValidationResult {
        case success
        case failure(String) // Includes an error message
    }
}
