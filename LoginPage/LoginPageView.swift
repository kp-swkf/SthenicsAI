import SwiftUI

struct LoginPageView: View {
    @StateObject private var viewModel = LoginPageViewModel()
    @EnvironmentObject private var coordinator: Coordinator
    @State private var rememberMe: Bool = false
    @State private var isShowingCreateAccount = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack(path: $coordinator.path) { // ✅ Use NavigationStack with Coordinator
            VStack(spacing: 10) {
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
                EmailInputView(email: $viewModel.email, errorMessage: $viewModel.emailErrorMessage)
                
                // ✅ Show email-specific error message
                if !viewModel.emailErrorMessage.isEmpty {
                    Text(viewModel.emailErrorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                // Password Input Field
                PasswordInputView(password: $viewModel.password, errorMessage: $viewModel.passwordErrorMessage)
                // ✅ Show password-specific error message
                if !viewModel.passwordErrorMessage.isEmpty {
                    Text(viewModel.passwordErrorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

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
                    Task {
                        await viewModel.login()
                        if viewModel.isAuthenticated {
                            coordinator.push(.home) // ✅ Navigate to HomeView
                        }
                    }
                }) {
                    Text(viewModel.isLoading ? "Logging In..." : "Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isLoading ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.isLoading)
                
                // Forgot Password Link
                Button(action: {
                    coordinator.push(.forgotPassword) // ✅ Navigate to Forgot Password
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.blue)
                        .font(.footnote)
                }
                
                Spacer().frame(height: 10)
                
                // Sign Up with Google
                Button(action: {
                    // TODO: Implement Google Sign-In
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
                    // TODO: Implement Apple Sign-In
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
                    Button(action: {
                        isShowingCreateAccount = true
                    }) {
                        Text("Create Account")
                            .foregroundColor(.blue)
                            .fontWeight(.medium)
                    }
                }
                .font(.footnote)
                .padding()
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $isShowingCreateAccount) {
                CreateAccountView()
                    .environmentObject(coordinator)
            }
        }
        .navigationBarHidden(true)
        .onTapGesture {
            isFocused = false // Dismiss keyboard
            viewModel.emailErrorMessage = "" // ✅ Clear email error
            viewModel.passwordErrorMessage = "" // ✅ Clear password error
        }
        .navigationDestination(for: AppScreen.self) { screen in // ✅ Handle navigation changes
            switch screen {
            case .home:
                HomePageView()
            case .signUp:
                CreateAccountView()
            case .forgotPassword:
                ForgotPasswordView()
            }
        }
    }
}

#Preview {
    LoginPageView().environmentObject(Coordinator())
}
