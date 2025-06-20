import Foundation
import Combine

// This class manages all user data.
// ObservableObject: Notifies SwiftUI to update the view when its data changes.
class UserData: ObservableObject {
    
    // @Published: Automatically broadcasts notifications when this property changes.
    @Published var points: Int = 0
    @Published var plantedFlowers: [Flower] = []
    @Published var unlockedFlowerIDs: Set<String> = ["rose", "tulip"] // MODIFIED: Tulip is now unlocked by default

    // Complete flower library (can be fetched from a server, but for MVP it's built-in)
    let allFlowers: [Flower] = [
        Flower(id: "rose", name: "Rose", description: "A classic flower, symbolizing love and beauty."),
        Flower(id: "tulip", name: "Tulip", description: "Represents elegance and wealth."),
        Flower(id: "hyacinth", name: "Hyacinth", description: "Its language is 'everlasting remembrance'."),
        Flower(id: "forgetMeNot", name: "Forget-Me-Not", description: "Tiny and delicate, representing true love."),
        Flower(id: "balloonFlower", name: "Balloon Flower", description: "Its buds are as cute as balloons."),
        Flower(id: "iris", name: "Iris", description: "Resembles a dancing butterfly.")
    ]
    
    // Filename for saving data
    private let a_saveKey = "TimeBloomUserData"

    init() {
        loadData() // Load data when the app starts
    }

    // Computed property: returns an array of user's unlocked flower objects
    var unlockedFlowers: [Flower] {
        allFlowers.filter { unlockedFlowerIDs.contains($0.id) }
    }
    
    // Computed property: returns an array of user's locked flower objects
    var lockedFlowers: [Flower] {
        allFlowers.filter { !unlockedFlowerIDs.contains($0.id) }
    }

    // MARK: - User Actions

    func addPoints(_ amount: Int) {
        points += amount
        saveData()
    }

    func plantFlower(_ flower: Flower) {
        plantedFlowers.append(flower)
        saveData()
    }

    func unlockFlower(_ flower: Flower) {
        guard points >= flower.cost else { return } // Ensure points are sufficient
        
        points -= flower.cost
        unlockedFlowerIDs.insert(flower.id)
        saveData()
    }

    // MARK: - Data Persistence

    private func saveData() {
        // Pack user data into a simple struct
        let dataToSave = UserSessionData(points: points, plantedFlowers: plantedFlowers, unlockedFlowerIDs: unlockedFlowerIDs)
        
        // Use JSONEncoder to convert data to JSON format
        if let encodedData = try? JSONEncoder().encode(dataToSave) {
            // Use UserDefaults to save data
            UserDefaults.standard.set(encodedData, forKey: a_saveKey)
        }
    }

    private func loadData() {
        // Read data from UserDefaults
        if let savedData = UserDefaults.standard.data(forKey: a_saveKey) {
            // Use JSONDecoder to decode JSON data back to our struct
            if let decodedData = try? JSONDecoder().decode(UserSessionData.self, from: savedData) {
                // Restore data
                self.points = decodedData.points
                self.plantedFlowers = decodedData.plantedFlowers
                self.unlockedFlowerIDs = decodedData.unlockedFlowerIDs
                return // Loading successful, exit early
            }
        }
        // If loading fails (e.g., first time opening the app), use default values
        self.points = 0
        self.plantedFlowers = []
        self.unlockedFlowerIDs = ["rose", "tulip"] // MODIFIED: Default unlock
    }
}

// Helper struct for saving and loading
struct UserSessionData: Codable {
    var points: Int
    var plantedFlowers: [Flower]
    var unlockedFlowerIDs: Set<String>
}
