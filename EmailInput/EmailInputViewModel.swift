import Combine

@MainActor
final class EmailInputViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
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
    
    func signIn() {
        guard !email.isEmpty else {
            print("No email found")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error \(error)")
            }
        }
    }
}
