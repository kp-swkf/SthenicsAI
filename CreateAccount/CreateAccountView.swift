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
                    
                    // Email Input Field
                    EmailInputView(
                        email: $viewModel.email,  // Direct binding since email is non-optional
                        errorMessage: Binding(
                            get: { viewModel.emailError ?? "" },
                            set: { viewModel.emailError = $0.isEmpty ? nil : $0 }
                        )
                    )
                    
                    // Password Field
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    // Confirm Password Field
                    SecureField("Confirm Password", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
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
                    
                    // Display General Error Message
                    if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
                        Text(errorMessage)
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
                        Task {
                            await viewModel.createAccount()
                        }
                    }) {
                        Text(viewModel.isLoading ? "Creating Account..." : "Create Account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.isLoading ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(viewModel.isLoading)
                }
                .padding()
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
