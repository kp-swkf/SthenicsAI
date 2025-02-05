import SwiftUI

struct FitnessSurveyView: View {
    @State private var fitnessRating: Double = 5 // Default value for fitness rating
    @State private var exerciseDays: Double = 3 // Default value for exercise days
    @State private var motivationText: String = "" // Default value for motivation text
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Fitness Survey")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("How would you rate your overall fitness from 0-10?")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .minimumScaleFactor(0.8) // Shrinks text if needed
                    
                    Slider(value: $fitnessRating, in: 0...10, step: 1)
                        .onChange(of: fitnessRating) {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                    
                    Text("Your rating: \(Int(fitnessRating))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("On average, how many days do you currently exercise in a week (0-7)?")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .minimumScaleFactor(0.8)
                    
                    Slider(value: $exerciseDays, in: 0...7, step: 1)
                        .onChange(of: exerciseDays) {  // Updated for iOS 17+
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                    
                    Text("Days: \(Int(exerciseDays))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
            
                VStack(alignment: .leading, spacing: 10) {
                    Text("Why do you want to start your fitness journey?")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .minimumScaleFactor(0.8)
                    
                    ZStack(alignment: .topLeading) {
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
                                .padding(.horizontal, 12)
                                .padding(.top, 14)
                        }
                    }
                }
                .padding()
                
                Button(action: {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
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
                        .font(.headline)
                        .shadow(radius: 2)
                }
                .padding(.horizontal)
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    FitnessSurveyView()
}
