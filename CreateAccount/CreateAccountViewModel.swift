import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore


@MainActor
final class CreateAccountViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var dob = Date()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var didAttemptSubmit = false
    @Published var nameError: String?  
    @Published var emailError: String?
    @Published var passwordError: String?  
    @Published var dobError: String?  
    
    private var cancellables = Set<AnyCancellable>()
    private let authenticationManager = AuthenticationManager.shared
    
    func createAccount() async {
        didAttemptSubmit = true
        
        nameError = nil
        emailError = nil
        passwordError = nil
        dobError = nil
        
        let validations = [
            ValidationManager.validateName(firstName),
            ValidationManager.validateName(lastName),
            ValidationManager.validateEmail(email),
            ValidationManager.validatePassword(password),
            ValidationManager.validateDOB(dob)
        ]
        
        for (index, validation) in validations.enumerated() {
            if case .failure(let message) = validation {
                errorMessage = message
                switch index {
                case 0:
                    nameError = message
                case 1:
                    nameError = message
                case 2:
                    emailError = message
                case 3:
                    passwordError = message
                case 4:
                    dobError = message
                default:
                    break
                }
                return
            }
        }
        
        isLoading = true
        do {
            let authResult = try await authenticationManager.createUser(email: email, password: password)
            try await saveUserData(uid: authResult.uid)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    private func saveUserData(uid: String) async throws {
        let user = [
            "uid": uid,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "dob": dob.timeIntervalSince1970
        ] as [String: Any]
        try await Firestore.firestore().collection("users").document(uid).setData(user)
    }
}
