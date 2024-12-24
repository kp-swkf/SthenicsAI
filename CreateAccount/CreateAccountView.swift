import SwiftUI

struct CreateAccountView: View {
    @StateObject private var viewModel = CreateAccountViewModel()

    var body: some View {
        NavigationView {
            ScrollView { // Allow scrolling if content overflows
                VStack(spacing: 20) { // Reduce spacing to fit everything better
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

                    // Error Message
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
                        if viewModel.isDOBValid {
                            print("Proceeding with account creation...")
                        }
                    }) {
                        Text("Create Account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.isDOBValid ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!viewModel.isDOBValid)
                }
                .padding()
            }
            .navigationBarTitle("", displayMode: .inline) // Hides NavigationView title
        }
    }
}

#Preview {
    CreateAccountView()
}
