import Foundation

struct Flower: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let description: String
    
    // Image and Animation resource names
    var bloomedImageName: String { "\(id)Bloomed" }
    // MODIFIED: This now points to the new sway GIF animation names.
    var growingAnimationName: String? { id == "rose" || id == "tulip" ? "\(id)_growing_sway" : nil }
    var wiltedImageName: String? { id == "rose" || id == "tulip" ? "\(id)Wilted" : nil }
    
    // Renamed to "Petal Points" for a softer feel
    var cost: Int = 30
    
    var identifiableId: String { id }
}
