import Foundation
import Combine


class CreateAccountViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var dob: Date = Date()
    @Published var haveAccount: Bool = false
    @Published var error: Error?
    @Published var errorMessage: String = ""
    @Published var isDOBValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $dob
            .sink { [weak self] newDob in
                self?.validateDOB(newDob)
            }
            .store(in: &cancellables)
    }
    
    func validateDOB(_ dob: Date) {
        let calendar = Calendar.current
        let today = Date()
        
        if dob > today {
            errorMessage = "DOB cannot be in the future"
            isDOBValid = false
            return
        }
        guard let age = calendar.dateComponents([.year], from: dob, to: today).year else {
            errorMessage = "Invalid Date of Birth."
            isDOBValid = false
            return
        }
        
        if age < 16 {
            errorMessage = "You must be at least 16 years old."
            isDOBValid = false
            return
        }
        else {
            errorMessage = ""
            isDOBValid = true
        }
        
    }
    
}


