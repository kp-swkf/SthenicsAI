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
    @Published var isDOBValid: Bool = false
    @Published var arePasswordsValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var model: CreateAccountModel
    
    init(model: CreateAccountModel = CreateAccountModel(firstName: "", lastName: "", password: "", confirmPassword: "", email: "", dob: Date(), haveAccount: false)) {
        self.model = model
        
        // Bind model properties to ViewModel properties
        firstName = model.firstName
        lastName = model.lastName
        password = model.password
        confirmPassword = model.confirmPassword
        email = model.email
        dob = model.dob
        haveAccount = model.haveAccount
        
        // Observe changes to dob and validate
        $dob
            .sink { [weak self] newDob in
                self?.validateDOB(newDob)
            }
            .store(in: &cancellables)
    }
    
    // Validation logic using the Model
    func validateDOB(_ dob: Date) {
        model.dob = dob
        let validation = model.isDOBValid()
        isDOBValid = validation.valid
        errorMessage = validation.errorMessage ?? ""
    }
    
    // Update the model when user updates the ViewModel fields
    func updateModel() {
        model.firstName = firstName
        model.lastName = lastName
        model.password = password
        model.confirmPassword = confirmPassword
        model.email = email
        model.dob = dob
        model.haveAccount = haveAccount
    }
    
    // Check if passwords match
    func checkPassword() {
        model.password = password
        model.confirmPassword = confirmPassword
        let validation = model.doPasswordsMatch()
        arePasswordsValid = validation.valid
        errorMessage = validation.errorMessage ?? ""
    }
}
