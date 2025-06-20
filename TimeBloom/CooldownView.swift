import SwiftUI

enum SessionResult: Identifiable {
    case success
    case failure
    var id: Self { self }
}

struct CooldownView: View {
    @EnvironmentObject var userData: UserData
    @Binding var isPresented: Bool
    
    let flowerToPlant: Flower
    let durationInSeconds: Int
    
    @State private var timeRemaining: Int
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var sessionResult: SessionResult? = nil
    
    private let activitySuggestions = [ "Try a Sudoku or a crossword puzzle.", "Brew a cup of tea and sit quietly for five minutes.", "Listen to a classic nostalgic song.", "Stand up and do some simple neck and shoulder stretches." ]
    @State private var suggestion = ""

    init(isPresented: Binding<Bool>, flowerToPlant: Flower, durationInSeconds: Int) {
        self._isPresented = isPresented
        self.flowerToPlant = flowerToPlant
        self.durationInSeconds = durationInSeconds
        self._timeRemaining = State(initialValue: durationInSeconds)
    }

    var body: some View {
        ZStack {
            // MODIFIED: Added the garden background image here as well.
            Image("gardenBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                
            
            // Added a translucent overlay to ensure text is readable.
            Theme.background.opacity(0.8).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer(minLength: 40)
                
                Text("Put down your phone,\nlive in the moment.")
                    .font(.largeTitle).fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.text)
                
                Spacer()
                
                // MODIFIED: The GIFView now has a flexible frame that allows it to expand.
                if let gifName = flowerToPlant.growingAnimationName {
                    GIFView(gifName)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // This allows the GIF to take up space
                        .aspectRatio(1.0, contentMode: .fit) // Keep it square-ish
                } else {
                    Image("defaultSeed").resizable().scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Spacer()
                VStack {
                    Text(timeString(from: timeRemaining))
                        .font(.system(size: 60, design: .monospaced))
                        .fontWeight(.bold).foregroundColor(Theme.text)
                    Spacer()
                    VStack {
                        Text("On completion:")
                        Text("+1 Flower, +5 Petal Points").fontWeight(.semibold)
                    }
                    .font(.subheadline).foregroundColor(.secondary)
                    
                    Spacer()

                    Button("End Moment") {
                        self.timer.upstream.connect().cancel()
                        self.sessionResult = .failure
                    }
                    .fontWeight(.semibold).foregroundColor(Theme.buttonText)
                    .padding()
                   
                    .background(Theme.primaryButton).cornerRadius(15)

                }
                .padding(40)
                
                .cornerRadius(15)
                            }
            .padding(40)
        }
        .onReceive(timer) { _ in
            guard sessionResult == nil else { return }
            
            if self.timeRemaining > 0 { self.timeRemaining -= 1 } else {
                self.timer.upstream.connect().cancel()
                self.userData.addPoints(5)
                self.userData.plantFlower(self.flowerToPlant)
                self.suggestion = activitySuggestions.randomElement() ?? ""
                self.sessionResult = .success
            }
        }
        .sheet(item: $sessionResult) { result in
            ResultView(isPresented: $isPresented, result: result, flower: flowerToPlant, suggestion: suggestion)
        }
    }

    private func timeString(from totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ResultView: View {
    @Binding var isPresented: Bool
    let result: SessionResult
    let flower: Flower
    let suggestion: String
    
    var body: some View {
        ZStack {
            Theme.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                switch result {
                case .failure:
                    Image(flower.wiltedImageName ?? "defaultSeed").resizable().scaledToFit().frame(width: 150)
                    Text("Moment Ended").font(.largeTitle).fontWeight(.bold).foregroundColor(Theme.text)
                    Text("It's okay to take a break when you need it.").foregroundColor(.secondary)
                
                case .success:
                    Image(flower.bloomedImageName).resizable().scaledToFit().frame(width: 150)
                    Text("Welcome Back!").font(.largeTitle).fontWeight(.bold).foregroundColor(Theme.text)
                    Text("You've earned 5 Petals and a beautiful \(flower.name)!").multilineTextAlignment(.center)
                    
                    if !suggestion.isEmpty {
                        VStack {
                           Text("Now, why not try this?").font(.headline).padding(.top).foregroundColor(Theme.text)
                           Text(suggestion).multilineTextAlignment(.center).padding().background(Theme.background.brightness(-0.05)).cornerRadius(10)
                        }
                    }
                }
                
                Button("Done") { self.isPresented = false }
                    .fontWeight(.semibold).foregroundColor(Theme.buttonText).padding().frame(maxWidth: .infinity).background(Theme.primaryButton).cornerRadius(15).padding(.top)
            }
            .padding(40)
        }
    }
}
