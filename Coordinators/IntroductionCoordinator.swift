import SwiftUI
import Foundation

// Define all the possible screens in your app
enum AppScreen: Hashable {
    // Authentication Flow
    case login
    case signUp
    case forgotPassword

    // Onboarding Flow
    case welcome
    case tutorial

    // Main Application Flow
    case home
    case profile
    case settings
}

// A large coordinator that manages the entire app flow
final class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    // MARK: - Navigation Methods
    
    /// Push a new screen onto the navigation stack.
    func push(_ screen: AppScreen) {
        path.append(screen)
    }
    
    /// Pop the last screen from the navigation stack.
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    /// Reset the navigation path to its root.
    func reset() {
        path = NavigationPath()
    }
    
    // MARK: - Flow Control Methods
    
    /// Begin the authentication flow by resetting and pushing the login screen.
    func startAuthFlow() {
        reset()
        push(.login)
    }
    
    /// Begin the onboarding flow by resetting and pushing the welcome screen.
    func startOnboardingFlow() {
        reset()
        push(.welcome)
    }
    
    /// Begin the main application flow by resetting and pushing the home screen.
    func startMainFlow() {
        reset()
        push(.home)
    }
}
