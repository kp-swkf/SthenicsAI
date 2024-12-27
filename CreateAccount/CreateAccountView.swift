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

                    // Email Field
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .textInputAutocapitalization(.none)
                        .keyboardType(.emailAddress)

                    // Password Field
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    // Confirm Password Field
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .onChange(of: viewModel.confirmPassword) { _ in
                            viewModel.checkPassword()
                        }

                    // Password Match Error Message
                    if !viewModel.arePasswordsValid {
                        Text("Passwords do not match.")
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

                    // General Error Message
                    if !viewModel.errorMessage.isEmpty {
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

                    // Submit Button
                    Button(action: {
                        viewModel.updateModel()
                        if viewModel.isDOBValid && viewModel.arePasswordsValid {
                            print("Proceeding with account creation...")
                        }
                    }) {
                        Text("Create Account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.isDOBValid && viewModel.arePasswordsValid ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!viewModel.isDOBValid || !viewModel.arePasswordsValid)
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
