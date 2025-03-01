import SwiftUI
import SwiftfulRouting

struct LoginPageView: View {
    @StateObject private var viewModel = LoginPageViewModel()
    @State private var rememberMe: Bool = false
    @State private var isShowingCreateAccount = false
    @FocusState private var isFocused: Bool
    @Environment(\.router) var router
    
    var body: some View {
        RouterView { _ in
            ZStack {
                VStack(spacing: 10) {
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer().frame(height: 25)
                    
                    LottieView(animationName: "LoginPageProfile", scale: 0.01)
                        .frame(width: 150, height: 150)
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 4)
                        )
                        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 4)
                    
                    Spacer().frame(height: 55)
                    
                    EmailInputView(email: $viewModel.email,
                                   errorMessage: $viewModel.emailErrorMessage)
                    
                    if !viewModel.emailErrorMessage.isEmpty {
                        Text(viewModel.emailErrorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    PasswordInputView(password: $viewModel.password,
                                      errorMessage: $viewModel.passwordErrorMessage)
                    
                    if !viewModel.passwordErrorMessage.isEmpty {
                        Text(viewModel.passwordErrorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        Toggle(isOn: $rememberMe) {
                            Text("Remember Me")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                        Spacer()
                    }
                    
                    Button(action: {
                        Task {
                            await viewModel.login()
                            if viewModel.isAuthenticated {
                                router.showScreen(.push) {_ in
                                    HomePageView()
                                }
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
                    
                    Spacer().frame(height: 10)
                    
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
                    
                    HStack {
                        Text("Haven't started your journey yet?")
                        Button(action: {
                            isShowingCreateAccount = true
                        }) {
                            Text("Create Account")
                                .foregroundColor(.white)
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
                }
                .onTapGesture {
                    isFocused = false
                    viewModel.emailErrorMessage = ""
                    viewModel.passwordErrorMessage = ""
                }
            }.customBackground()
        }
    }
}

#Preview {
    LoginPageView()
}
