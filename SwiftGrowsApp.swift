import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

@main
struct SwiftGrowsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var coordinator = Coordinator() // ✅ Declare @StateObject globally

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) { // ✅ Now $coordinator is in scope
                LoginPageView()
                    .environmentObject(coordinator) // ✅ Inject Coordinator properly
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        if let app = FirebaseApp.app() {
            print("✅ Firebase initialized: \(app.name)")
        } else {
            print("❌ Firebase failed to initialize")
        }

        return true
    }
}
