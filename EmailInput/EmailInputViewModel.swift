import Combine

class EmailInputViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isFocused: Bool = false
    @Published private(set) var isValid: Bool = false
    @Published private(set) var errorMessage: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $email
            .sink { [weak self] newValue in
                self?.validateEmail(email: newValue)
            }
            .store(in: &cancellables)
    }
    
    func validateEmail(email: String) {
        if email.isEmpty {
            isValid = false
            errorMessage = "Please enter your email address."
        } else if EmailValidator().isValid(email: email) {
            isValid = true
            errorMessage = ""
        } else {
            isValid = false
            errorMessage = "Please enter a valid email address."
        }
    }
}
