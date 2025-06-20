import SwiftUI

struct SettingsView: View {
    var body: some View {
        // MODIFIED: Re-added the NavigationView wrapper. This is essential for NavigationLink to work.
        NavigationView {
            Form {
                Section(header: Text("About TimeBloom")) {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text("1.0.1 (MVP)")
                    }
                }

                Section(header: Text("Community")) {
                    // This NavigationLink can now function correctly.
                    NavigationLink(destination: CommunityImpactView()) {
                        HStack(spacing: 15) {
                            Image(systemName: "heart.text.square.fill")
                                .foregroundColor(Theme.primaryButton)
                            Text("Community Impact")
                        }
                    }
                }

                Section(header: Text("Activity Suggestions")) {
                   Text("Brain Health: Try a Sudoku or a crossword puzzle.")
                   Text("Relaxing Moment: Brew a cup of tea and sit quietly for five minutes.")
                   Text("Arts & Culture: Listen to a classic nostalgic song.")
                   Text("Light Physical Activity: Stand up and do some simple neck and shoulder stretches.")
                }
            }
            .scrollContentBackground(.hidden)
            .background(Theme.background)
            .navigationTitle("Settings")
        }
        // MODIFIED: Applying the stack style prevents issues when this view is nested in a TabView
        // and ensures the Tab Bar remains visible.
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


// You can also add a preview for this specific screen to test it in isolation.
#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        // The preview itself needs a NavigationView to render the title and links correctly.
        NavigationView {
            SettingsView()
                .environmentObject(UserData())
        }
    }
}
#endif
