import Foundation

struct ValidationManager {
    // Validates email format
    static func validateEmail(_ email: String) -> ValidationResult {
        if email.isEmpty {
            return .failure("Please enter your email address.")
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email) ? .success : .failure("Invalid email format.")
    }
    // Validates password with multiple rules
    static func validatePassword(_ password: String) -> ValidationResult {
        if password.isEmpty {
            return .failure("Password cannot be empty.")
        }
        if password.count < 8 {
            return .failure("Password must be at least 8 characters.")
        }
        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
        let hasDigit = password.range(of: "\\d", options: .regularExpression) != nil
        let hasSpecial = password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil
        
        if !hasUppercase || !hasLowercase || !hasDigit || !hasSpecial {
            return .failure("Password must include uppercase, lowercase, a number, and a special character.")
        }
        
        return .success
    }
    
    // Validates name (only letters, spaces, hyphens, and apostrophes allowed)
    static func validateName(_ name: String) -> ValidationResult {
        if name.isEmpty {
            return .failure("Name cannot be empty.")
        }
        if name.count > 50 {
            return .failure("Name cannot exceed 50 characters.")
        }
        let nameRegex = "^[a-zA-Z\\s'-]+$"
        return name.range(of: nameRegex, options: .regularExpression) != nil
            ? .success : .failure("Name can only contain letters, spaces, hyphens, and apostrophes.")
    }
    
    // Validates DOB (must be at least 16 years old)
    static func validateDOB(_ dob: Date) -> ValidationResult {
        let calendar = Calendar.current
        let today = Date()
        
        if dob > today {
            return .failure("Date of birth cannot be in the future.")
        }
        guard let age = calendar.dateComponents([.year], from: dob, to: today).year, age >= 16 else {
            return .failure("You must be at least 16 years old.")
        }
        
        return .success
    }
}

// ValidationResult Enum
enum ValidationResult {
    case success
    case failure(String)
}
