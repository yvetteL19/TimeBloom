import SwiftUI

struct ContentView: View {
    var body: some View {
        // TabView: 创建一个底部导航栏界面
        TabView {
            // 第一个标签页：主页a
            HomeView()
                .tabItem {
                    // 使用 SF Symbols 作为图标
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            // 第二个标签页：我的花园
            GardenView()
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("My Garden")
                }

            // 第三个标签页：设置
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        // MODIFIED: We are using the theme color now for consistency.
        .accentColor(Theme.primaryButton)
    }
}


// MODIFIED: Added this entire block to enable Xcode Previews for the whole app.
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // We create a sample UserData instance specifically for the preview.
        let sampleUserData = UserData()
        
        // This ZStack is added to replicate the global background color
        // that is set in TimeBloomApp.swift, ensuring the preview looks accurate.
        ZStack {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            // Return the ContentView for previewing.
            ContentView()
                // We must provide the same environment objects that the real app uses.
                .environmentObject(sampleUserData)
        }
    }
}
#endif
