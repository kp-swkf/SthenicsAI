import SwiftUI

struct WorkoutView: View {
    var body: some View {
        ZStack {
            // Your main content
            Color(.systemBackground).ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Action to add a workout
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                            .background(Circle().fill(Color.white).shadow(radius: 4))
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview{
    WorkoutView()
}
