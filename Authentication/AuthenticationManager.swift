import FirebaseAuth
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
