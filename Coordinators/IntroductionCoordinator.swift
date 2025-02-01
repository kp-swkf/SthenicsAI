import SwiftUI
import Foundation

enum AppScreen: Hashable {
    case home
    case signUp
    case forgotPassword
}

final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ screen: AppScreen) {
        path.append(screen)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func reset() {
        path = NavigationPath()
    }
    
}
