import Foundation

struct CreateAccountModel {
    var firstName: String
    var lastName: String
    var password: String
    var confirmPassword: String
    var email: String
    var dob: Date
    var haveAccount: Bool
    
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
}
