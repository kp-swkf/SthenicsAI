import Combine
import Foundation

class CreateAccountViewModel: ObservableObject {
    // Published properties for the UI
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
    @Published var dob: Date = Date()
    @Published var haveAccount: Bool = false
    @Published var errorMessage: String = ""
    
    // Added new validation error properties
    @Published var nameError: String? = nil
    @Published var emailError: String? = nil
    @Published var passwordStrengthError: String? = nil
    @Published var passwordMatchError: String? = nil
    @Published var dobError: String? = nil
    @Published var isFormValid: Bool = false
    
    // Added didAttemptSubmit flag
    @Published var didAttemptSubmit: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var model: CreateAccountModel
    
    init(model: CreateAccountModel = CreateAccountModel(firstName: "", lastName: "", password: "", confirmPassword: "", email: "", dob: Date(), haveAccount: false)) {
        self.model = model
        setupBindings()
        
        // Bind model properties to ViewModel properties
        firstName = model.firstName
        lastName = model.lastName
        password = model.password
        confirmPassword = model.confirmPassword
        email = model.email
        dob = model.dob
        haveAccount = model.haveAccount
    }
    
    // Added new setupBindings method
    private func setupBindings() {
        Publishers.CombineLatest4($firstName, $lastName, $email, $dob)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] firstName, lastName, email, dob in
                self?.validateForm()
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($password, $confirmPassword)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] _, _ in
                self?.validatePasswords()
            }
            .store(in: &cancellables)
    }
    
    // Added new validateForm method
    func validateForm() {
        model.firstName = firstName
        model.lastName = lastName
        model.email = email
        model.dob = dob
        
        let namesValidation = model.areNamesValid()
        nameError = namesValidation.errorMessage
        
        let emailValidation = model.isEmailValid()
        emailError = emailValidation.errorMessage
        
        let dobValidation = model.isDOBValid()
        dobError = dobValidation.errorMessage
        
        updateFormValidity()
    }
    
    // Modified password validation
    func validatePasswords() {
        model.password = password
        model.confirmPassword = confirmPassword
        
        let strengthValidation = model.isPasswordStrong()
        passwordStrengthError = strengthValidation.errorMessage
        
        let matchValidation = model.doPasswordsMatch()
        passwordMatchError = matchValidation.errorMessage
        
        updateFormValidity()
    }
    
    // Added new updateFormValidity method
    private func updateFormValidity() {
        let validation = model.isValid()
        isFormValid = validation.valid
        errorMessage = validation.errorMessage ?? ""
    }
    
    // Modified validateAndCreateAccount method
    func validateAndCreateAccount() {
        didAttemptSubmit = true
        validateForm()
        validatePasswords()
        
        if isFormValid {
            print("Proceeding with account creation...")
            // Add
        }
    }
}
