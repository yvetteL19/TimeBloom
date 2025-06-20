import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userData: UserData
    
    @State private var isShowingCooldown = false
    @State private var selectedFlowerID: String = "rose"
    @State private var focusDurationMinutes: Double = 20.0

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    headerView
                    
                    greetingView
                    
                    screenTimeView
                    
                    cooldownSessionView
                    
                }
                .padding()
            }
            .background(Theme.background.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            .onAppear {
                if !userData.unlockedFlowers.isEmpty && !userData.unlockedFlowers.contains(where: { $0.id == selectedFlowerID }) {
                    selectedFlowerID = userData.unlockedFlowers.first!.id
                }
            }
            .sheet(isPresented: $isShowingCooldown) {
                if let flower = userData.allFlowers.first(where: { $0.id == selectedFlowerID }) {
                     CooldownView(isPresented: $isShowingCooldown, flowerToPlant: flower, durationInSeconds: Int(focusDurationMinutes) * 60)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var headerView: some View {
        HStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            
            Spacer()
            
            HStack(spacing: 5) {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.yellow)
                Text("\(userData.points)")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Petals")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.black.opacity(0.05))
            .cornerRadius(20)
        }
    }
    
    private var greetingView: some View {
        VStack(alignment: .leading) {
            Text("Good Afternoon,")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Ready to find a moment of peace?")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
    
    private var screenTimeView: some View {
        VStack {
            HStack {
                Text("Today's Screen Time")
                    .font(.headline)
                Spacer()
                Text("3h 45m") // This is a static placeholder for the MVP
                    .font(.headline)
                    .foregroundColor(Theme.primaryButton)
            }
            Text("This data is illustrative. Automatic tracking will be available in a future version.")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(15)
    }
    
    private var cooldownSessionView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Start a Quiet Moment")
                .font(.title2)
                .fontWeight(.bold)
            
            // Flower selection
            VStack(alignment: .leading, spacing: 8) {
                Text("1. Choose a flower to nurture").font(.subheadline).foregroundColor(.secondary)
                FlowerSelectionMenu(selectedFlowerID: $selectedFlowerID)
            }
            
            // Duration selection
            VStack(alignment: .leading, spacing: 8) {
                Text("2. Set your desired time").font(.subheadline).foregroundColor(.secondary)
                VStack {
                    Slider(value: $focusDurationMinutes, in: 1...120, step: 1)
                    Text("\(Int(focusDurationMinutes)) minutes")
                        .fontWeight(.semibold)
                }
            }

            Button(action: { isShowingCooldown = true }) {
                Text("Begin Your Calm Time")
                    .fontWeight(.semibold)
                    .foregroundColor(Theme.buttonText)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(userData.unlockedFlowers.isEmpty ? Color.gray : Theme.primaryButton)
                    .cornerRadius(15)
            }
            .disabled(userData.unlockedFlowers.isEmpty)
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(15)
    }
}

// A new sub-view for the flower selection dropdown for better code organization.
struct FlowerSelectionMenu: View {
    @EnvironmentObject var userData: UserData
    @Binding var selectedFlowerID: String

    var body: some View {
        Menu {
            ForEach(userData.unlockedFlowers, id: \.id) { flower in
                Button(action: { selectedFlowerID = flower.id }) {
                    HStack {
                        Text(flower.name)
                        Image(flower.bloomedImageName)
                    }
                }
            }
        } label: {
            HStack {
                if let flower = userData.allFlowers.first(where: { $0.id == selectedFlowerID }) {
                    Image(flower.bloomedImageName)
                        .resizable().scaledToFit().frame(width: 30, height: 30)
                    Text(flower.name).font(.headline)
                } else {
                    Text("Select a Flower")
                }
                Spacer()
                Image(systemName: "chevron.down").font(.caption)
            }
            .foregroundColor(Theme.text)
            .padding(12)
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
        }
    }
}
