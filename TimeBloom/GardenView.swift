import SwiftUI

struct GardenView: View {
    @EnvironmentObject var userData: UserData
    @State private var isShowingStore = false
    @State private var isShowingShareSheet = false

    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        NavigationView {
            ZStack {
                // MODIFIED: This ensures the background image fills the entire screen
                // without distortion, which was the main issue.
                Image("gardenBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                // The semi-transparent overlay is layered on top.
                Theme.background.opacity(0.3).edgesIgnoringSafeArea(.all)
                
                if userData.plantedFlowers.isEmpty {
                    emptyGardenView
                } else {
                    gardenGridView
                }
            }
            .navigationTitle("My Garden")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 20) {
                        Button(action: { isShowingShareSheet = true }) { Image(systemName: "square.and.arrow.up") }
                        Button(action: { isShowingStore = true }) { Image(systemName: "storefront.fill") }
                    }
                    .foregroundColor(Theme.primaryButton)
                }
            }
            .sheet(isPresented: $isShowingStore) { SeedStoreView() }
            .sheet(isPresented: $isShowingShareSheet) { ShareView() }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var gardenGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(userData.plantedFlowers.indices, id: \.self) { index in
                    let flower = userData.plantedFlowers[index]
                    VStack {
                        Image(flower.bloomedImageName)
                            .resizable().scaledToFit().frame(width: 80, height: 80)
                            .padding().background(Color.white.opacity(0.5)).cornerRadius(15)
                        Text(flower.name).font(.caption).foregroundColor(.white).fontWeight(.bold).shadow(radius: 2)
                    }
                }
            }
            .padding()
            .padding(.top) // Padding to avoid notch/navbar
        }
    }
    
    private var emptyGardenView: some View {
        VStack(spacing: 10) {
            Image(systemName: "wind").font(.system(size: 60)).foregroundColor(.white.opacity(0.8))
            Text("Your garden is empty").font(.title2).foregroundColor(.white)
            Text("Go to the 'Home' tab to complete a focus session and plant your first flower!")
                .font(.subheadline).foregroundColor(.white.opacity(0.8)).multilineTextAlignment(.center).padding(.horizontal)
        }
    }
}
