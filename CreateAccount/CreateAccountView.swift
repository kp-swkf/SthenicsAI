import SwiftUI

struct CreateAccountView: View {
    @StateObject private var viewModel = CreateAccountViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)

                    // First Name Field
                    TextField("First Name", text: $viewModel.firstName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .textInputAutocapitalization(.words)
                        .keyboardType(.default)

                    // Last Name Field
                    TextField("Last Name", text: $viewModel.lastName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .textInputAutocapitalization(.words)
                        .keyboardType(.default)

                    // Modified name error to show only after submit
                    if viewModel.didAttemptSubmit, let nameError = viewModel.nameError {
                        Text(nameError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Email Field
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .textInputAutocapitalization(.none)
                        .keyboardType(.emailAddress)

                    // Modified email error
                    if viewModel.didAttemptSubmit, let emailError = viewModel.emailError {
                        Text(emailError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Password Field
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    // Modified password strength error
                    if viewModel.didAttemptSubmit, let passwordStrengthError = viewModel.passwordStrengthError {
                        Text(passwordStrengthError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Confirm Password Field
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    // Modified password match error
                    if viewModel.didAttemptSubmit, let passwordMatchError = viewModel.passwordMatchError {
                        Text(passwordMatchError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Date Picker for DOB
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Date of Birth")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        DatePicker("", selection: $viewModel.dob, displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                    // Modified DOB error
                    if viewModel.didAttemptSubmit, let dobError = viewModel.dobError {
                        Text(dobError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Modified general error message
                    if viewModel.didAttemptSubmit, !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Sign In Link
                    HStack {
                        Text("Already have an account?")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        NavigationLink(destination: LoginPageView()) {
                            Text("Sign In")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                    }

                    // Modified Submit Button
                    Button(action: {
                        viewModel.validateAndCreateAccount()
                    }) {
                        Text("Create Account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateAccountView()
                .previewDisplayName("Default State")
                .environment(\.locale, .init(identifier: "en")) // Default English locale
            
            CreateAccountView()
                .previewDisplayName("Error State")
                .environmentObject(
                    CreateAccountViewModel(
                        model: CreateAccountModel(
                            firstName: "John",
                            lastName: "Doe",
                            password: "password123",
                            confirmPassword: "password456", // Password mismatch
                            email: "john.doe@example.com",
                            dob: Date(timeIntervalSince1970: 315569952),
                            haveAccount: false
                        )
                    )
                )
        }
    }
}
