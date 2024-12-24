import SwiftUI

struct FitnessSurveyView: View {
    @State private var fitnessRating: Double = 5 // Default value for fitness rating
    @State private var exerciseDays: Double = 3 // Default value for exercise days
    @State private var motivationText: String = "" // Default value for motivation text
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("Fitness Survey")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // Question 1: Fitness Rating
                VStack(alignment: .leading, spacing: 10) {
                    Text("How would you rate your overall fitness from 0-10?")
                        .font(.headline)
                    
                    Slider(value: $fitnessRating, in: 0...10, step: 1)
                    
                    Text("Your rating: \(Int(fitnessRating))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                
                // Question 2: Exercise Days
                VStack(alignment: .leading, spacing: 10) {
                    Text("On average, how many days do you currently exercise in a week (0-7)?")
                        .font(.headline)
                    
                    Slider(value: $exerciseDays, in: 0...7, step: 1)
                    
                    Text("Days: \(Int(exerciseDays))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                
                // Question 3: Motivation
                VStack(alignment: .leading, spacing: 10) {
                    Text("Why do you want to start your fitness journey?")
                        .font(.headline)
                    
                    TextEditor(text: $motivationText)
                        .frame(height: 100)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    
                    if motivationText.isEmpty {
                        Text("Write your answer here...")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                            .padding(.top, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .allowsHitTesting(false) // Prevents interaction with placeholder
                    }
                }
                .padding()
                
                // Submit Button
                Button(action: {
                    print("Fitness Rating: \(Int(fitnessRating))")
                    print("Exercise Days: \(Int(exerciseDays))")
                    print("Motivation: \(motivationText)")
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    FitnessSurveyView()
}
