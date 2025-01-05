import Foundation

struct CreateAccountModel {
    var firstName: String
    var lastName: String
    var password: String
    var confirmPassword: String
    var email: String
    var dob: Date
    var haveAccount: Bool
    
    private let minimumPasswordLength = 8
    private let maximumNameLength = 50
    
    /// Validate if the provided date of birth is valid and meets the age requirement.
    func isDOBValid() -> (valid: Bool, errorMessage: String?) {
        let calendar = Calendar.current
        let today = Date()
        
        if dob > today {
            return (false, "DOB cannot be in the future")
        }
        
        guard let age = calendar.dateComponents([.year], from: dob, to: today).year else {
            return (false, "Invalid Date of Birth.")
        }
        
        if age < 16 {
            return (false, "You must be at least 16 years old.")
        }
        
        return (true, nil)
    }
    
    /// Check if password and confirmPassword match.
    func doPasswordsMatch() -> (valid: Bool, errorMessage: String?) {
        if password.isEmpty || confirmPassword.isEmpty {
            return (false, "Password fields cannot be empty")
        }
        if password != confirmPassword {
            return (false, "Passwords do not match")
        }
        return (true, nil)
    }
    
    func isPasswordStrong() -> (valid: Bool, errorMessage: String?) {
        if password.count < minimumPasswordLength {
            return (false, "Password must be at least \(minimumPasswordLength) characters")
        }
        
        let hasUppercase = password.contains(where: { $0.isUppercase })
        let hasLowercase = password.contains(where: { $0.isLowercase })
        let hasNumber = password.contains(where: { $0.isNumber })
        let hasSpecialCharacter = password.contains(where: { "!@#$%^&*()_+-=[]{}|;:,.<>?".contains($0) })
        
        if !hasUppercase || !hasLowercase || !hasNumber || !hasSpecialCharacter {
            return (false, "Password must contain uppercase, lowercase, number, and special character")
        }
        
        return (true, nil)
    }
    
    func areNamesValid() -> (valid: Bool, errorMessage: String?) {
        if firstName.isEmpty || lastName.isEmpty {
            return (false, "Name fields cannot be empty")
        }
        
        if firstName.count > maximumNameLength || lastName.count > maximumNameLength {
            return (false, "Name cannot exceed \(maximumNameLength) characters")
        }
        
        let nameRegex = "^[a-zA-Z\\s'-]+$"
        let firstNameValid = firstName.range(of: nameRegex, options: .regularExpression) != nil
        let lastNameValid = lastName.range(of: nameRegex, options: .regularExpression) != nil
        
        if !firstNameValid || !lastNameValid {
            return (false, "Names can only contain letters, spaces, hyphens, and apostrophes")
        }
        
        return (true, nil)
    }
    
    func isEmailValid() -> (valid: Bool, errorMessage: String?) {
        if email.isEmpty {
            return (false, "Email cannot be empty")
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) {
            return (false, "Invalid email format")
        }
        
        return (true, nil)
    }
    
    func isValid() -> (valid: Bool, errorMessage: String?) {
        // Check names
        let namesValidation = areNamesValid()
        if !namesValidation.valid {
            return namesValidation
        }
        
        // Check email
        let emailValidation = isEmailValid()
        if !emailValidation.valid {
            return emailValidation
        }
        
        // Check DOB
        let dobValidation = isDOBValid()
        if !dobValidation.valid {
            return dobValidation
        }
        
        // Check password strength
        let passwordStrengthValidation = isPasswordStrong()
        if !passwordStrengthValidation.valid {
            return passwordStrengthValidation
        }
        
        // Check password match
        let passwordMatchValidation = doPasswordsMatch()
        if !passwordMatchValidation.valid {
            return passwordMatchValidation
        }
        
        return (true, nil)
    }
}
