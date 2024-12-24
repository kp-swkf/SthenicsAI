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
                
                // Email Input Field
                TextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($isFocused)
                
                // Validation Indicator
                if !viewModel.email.isEmpty {
                    Image(systemName: viewModel.isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(viewModel.isValid ? .green : .red)
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
                    .padding(.horizontal)
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
