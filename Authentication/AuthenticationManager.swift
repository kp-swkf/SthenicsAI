import FirebaseAuth
import Firebase
import FirebaseFirestore

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    // ✅ Create a new user in Firebase Authentication and store in Firestore
    func createUser(email: String, password: String, firstName: String, lastName: String, dob: Date) async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = AuthDataResultModel(user: authResult.user)
        
        // Store user details in Firestore
        try await saveUserData(uid: user.uid, firstName: firstName, lastName: lastName, email: email, dob: dob)
        
        return user
    }
    
    // ✅ Login an existing user in Firebase Authentication
    func login(email: String, password: String) async throws -> AuthDataResultModel {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authResult.user)
    }
    
    // ✅ Save user data to Firestore after signup
    private func saveUserData(uid: String, firstName: String, lastName: String, email: String, dob: Date) async throws {
        let userDocument: [String: Any] = [
            "uid": uid,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "dob": dob.timeIntervalSince1970
        ]
        try await Firestore.firestore().collection("users").document(uid).setData(userDocument)
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }

    func resetPassword(for email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

// ✅ Firebase Authentication Response Model
struct AuthDataResultModel {
    let uid: String
    let email: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}
