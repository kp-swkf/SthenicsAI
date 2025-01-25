import SwiftUI

struct EmailInputView: View {
    @ObservedObject var viewModel: EmailInputViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                // Email Icon
                Image(systemName: "envelope")
                    .foregroundColor(isFocused ? .blue : .gray)
                    .accessibilityLabel("Email Icon")
                
                // Email Input Field
                TextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($isFocused)
                    .submitLabel(.next)
                    .onChange(of: viewModel.email) { _ in
                        viewModel.validateEmail(email: viewModel.email)
                    }
                    .accessibilityLabel("Email Field")
                    .accessibilityHint("Enter your email address here")
                
                // Clear & Validate Button
                if !viewModel.email.isEmpty {
                    Button(action: {
                        viewModel.email = ""
                    }) {
                        Image(systemName: viewModel.isValid ? "xmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(viewModel.isValid ? .green : .red)
                            .accessibilityLabel("Clear and validate input")
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isFocused ? Color.blue : Color.clear, lineWidth: 1)
                    )
            )
            .padding(.horizontal)
            
            // Error Message
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16) // Align with text field padding
            }
        }
        .onChange(of: isFocused) { newValue in
            viewModel.isFocused = newValue
        }
    }
}

#Preview {
    EmailInputView(viewModel: EmailInputViewModel())
}
