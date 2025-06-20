import SwiftUI

struct SeedStoreView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        // The ZStack provides the base layer for our theme background color.
        ZStack {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            NavigationView {
                // MODIFIED: Replaced the problematic 'List' with a 'ScrollView' and 'VStack'
                // for full control over the background and layout.
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(userData.lockedFlowers) { flower in
                            // Each item is now a custom-built HStack inside a card-like background.
                            HStack(spacing: 15) {
                                Image("defaultSeed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                
                                Image(flower.bloomedImageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading) {
                                    Text(flower.name)
                                        .font(.headline)
                                        .foregroundColor(Theme.text)
                                    Text(flower.description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                // Exchange button
                                Button(action: {
                                    userData.unlockFlower(flower)
                                }) {
                                    Text("\(flower.cost) Petals")
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                        .foregroundColor(Theme.buttonText)
                                        .padding(8)
                                        .background(userData.points >= flower.cost ? Theme.primaryButton : Color.gray)
                                        .cornerRadius(10)
                                }
                                .disabled(userData.points < flower.cost)
                            }
                            .padding() // Add padding inside the card
                            .background(Color.white.opacity(0.7)) // Give each row a card-like background
                            .cornerRadius(15)
                        }
                    }
                    .padding() // Add padding around the entire VStack of cards
                }
                .navigationTitle("Seed Store")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Petals: \(userData.points)")
                            .font(.headline)
                            .foregroundColor(Theme.text)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(Theme.primaryButton)
                    }
                }
                // This ensures the area behind the ScrollView also has the correct background.
                .background(Theme.background)
            }
        }
    }
}

// Preview provider for SeedStoreView
#if DEBUG
struct SeedStoreView_Previews: PreviewProvider {
    static var previews: some View {
        SeedStoreView()
            .environmentObject(UserData())
    }
}
#endif
