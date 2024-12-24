import SwiftUI

struct PasswordInputView: View {
    @ObservedObject var viewModel: 	PasswordInputViewModel
    @FocusState private var isFocused: Bool
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                // Lock Icon
                Image(systemName: "lock")
                    .foregroundColor(isFocused ? .blue : .gray)
                
                // Password Input Field
                if isPasswordVisible {
                    TextField("Password", text: $viewModel.password)
                        .focused($isFocused)
                } else {
                    SecureField("Password", text: $viewModel.password)
                        .focused($isFocused)
                }
                
                // Show/Hide Password Button
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
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
    PasswordInputView(viewModel: PasswordInputViewModel())
}
