import SwiftUI

struct CommunityImpactView: View {
    var body: some View {
        // We use a ZStack to layer the background color behind the content.
        ZStack {
            // This sets the background color for this specific view.
            Color(Theme.background).edgesIgnoringSafeArea(.all)
                
            
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    Text("Growing Good, Together")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.8))

                    Text("Your focus makes a world of difference. Every flower you plant in your virtual garden contributes to our collective goal of making a real-world impact.")
                        .font(.body)
                        .lineSpacing(5)

                    // Progress Bar Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Community Goal: 10,000 Flowers for 1 Real Tree")
                            .font(.headline)
                        
                        // A static progress bar for the MVP.
                        ProgressView(value: 4500, total: 10000) {
                            Text("Progress")
                        } currentValueLabel: {
                            Text("4,500 / 10,000 Flowers Planted")
                        }
                        .tint(.green)
                    }
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)

                    // Announcements Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recent Milestones")
                            .font(.title2)
                            .fontWeight(.semibold)

                        // Announcement 1
                        VStack(alignment: .leading) {
                            Text("June 1st, 2025: First Milestone Achieved!")
                                .font(.headline)
                                .foregroundColor(.green)
                            Text("Thanks to the collective focus of our amazing users, TimeBloom has funded the planting of our first community tree through our partnership with 'One Tree Planted'. Your small breaks are creating a greener planet!")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        // Announcement 2
                        VStack(alignment: .leading) {
                            Text("Our Next Goal")
                                .font(.headline)
                            Text("We're setting our sights on our next goal of 10,000 flowers. Let's keep growing our gardens and our forest!")
                                .font(.subheadline)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Community Impact")
        .navigationBarTitleDisplayMode(.inline)
    }
}
