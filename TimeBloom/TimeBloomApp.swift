import SwiftUI

@main
struct TimeBloomApp: App {
    @StateObject private var userData = UserData()

    init() {
        // Configure the Tab Bar with the new background color.
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = UIColor(named: "AppBackgroundColor")?.withAlphaComponent(0.1)
        
        appearance.shadowColor = UIColor.gray.withAlphaComponent(0.3)
        
        // --- ERROR FIXED ---
        // The incorrect code block for adjusting icon padding has been removed
        // to resolve the compilation error. The app will now use the default
        // icon spacing, but it will build and run correctly.
        // ---
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            // Apply the new background color globally.
            ZStack {
                Theme.background.edgesIgnoringSafeArea(.all)
                
                ContentView()
                    .environmentObject(userData)
            }
        }
    }
}
