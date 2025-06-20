import SwiftUI

struct ShareView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    private var shareText: String {
        "I've planted \(userData.plantedFlowers.count) flowers in TimeBloom! Come join me in building healthier digital habits."
    }

    var body: some View {
        // MODIFIED: Wrapped in a ZStack to apply the theme background.
        ZStack {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Spacer()
                
                Text("Share Your Progress")
                    .font(.largeTitle).fontWeight(.bold).foregroundColor(Theme.text)
                
                VStack(spacing: 0) {
                    Image("gardenBackground").resizable().aspectRatio(contentMode: .fill).frame(height: 150).clipped()
                    
                    HStack {
                        Image("logo").resizable().scaledToFit().frame(width: 50).padding(.leading)
                        VStack(alignment: .leading) {
                            Text("My TimeBloom Garden").font(.headline)
                            Text("I've planted \(userData.plantedFlowers.count) flowers!").font(.subheadline).foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding().background(Color.white)
                }
                .cornerRadius(20).shadow(color: .black.opacity(0.2), radius: 10, y: 5).padding(.horizontal)

                ShareLink(item: shareText) {
                    Label("Share Now", systemImage: "square.and.arrow.up")
                        .font(.title2).foregroundColor(Theme.buttonText)
                        .padding().frame(maxWidth: .infinity)
                        .background(Theme.primaryButton)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                
                Spacer()

                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(Theme.primaryButton)
                .padding(.bottom)
            }
        }
    }
}
