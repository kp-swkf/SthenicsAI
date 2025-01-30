import SwiftUI

struct LoginPageView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var errorMessage: String? = nil
    @FocusState private var isFocused: Bool // Manage field focus

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                // App Logo or Title
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Logo
                Circle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                
                Spacer().frame(height: 75)
                
                // Email Input Field
                EmailInputView(
                    email: $email,
                    errorMessage: Binding(
                        get: { errorMessage ?? "" },
                        set: { errorMessage = (($0.isEmpty) != nil) ? nil : $0 }
                    )
                )
                
                // Password Input Field
                PasswordInputView(
                    password: $password,
                    errorMessage: Binding(
                        get: { errorMessage ?? "" },
                        set: { errorMessage = $0.isEmpty ? nil : $0 }
                    )
                )
                
                // Remember Me Toggle
                HStack {
                    Toggle(isOn: $rememberMe) {
                        Text("Remember Me")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    Spacer()
                }
                
                // Login Button
                Button(action: {
                    // Perform login action
                    print("Email: \(email), Password: \(password)")
                }) {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                // Forgot Password Link
                Button(action: {
                    // Handle Forgot Password Action
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.blue)
                        .font(.footnote)
                }
                
                Spacer().frame(height: 10)
                
                // Sign Up with Google
                Button(action: {
                    // Handle Google Sign-Up Action
                }) {
                    HStack {
                        Image(systemName: "g.circle")
                            .font(.title2)
                        Text("Sign Up with Google")
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                // Sign Up with Apple
                Button(action: {
                    // Handle Apple Sign-Up Action
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .font(.title2)
                        Text("Sign Up with Apple")
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                Spacer().frame(height: 10)
                
                // Create Account Navigation Link
                HStack {
                    Text("Haven't started your journey yet?")
                    NavigationLink(destination: CreateAccountView()) {
                        Text("Create Account")
                            .foregroundColor(.blue)
                            .fontWeight(.medium)
                    }
                }
                .font(.footnote)
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .onTapGesture {
                isFocused = false // Dismiss keyboard when tapping outside fields
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
