import UIKit

// MARK: - 1. Player Stats Model
struct PlayerStats {
    var calories: Int
    var runTimeMinutes: Int
    var currentStreak: Int // Stars/Streak count
    
}

// MARK: - 2. Character Model
struct GameCharacter {
    let id: String
    let name: String
    
    // Animation
    let gifName: String?
    let staticImageName: String
    
    // The Stats Box Image (CHANGED)
    let statsImageName: String // e.g., "stats_box_pink"
    
    // Logic
    var isSelected: Bool
    var isLocked: Bool
    
    var videoScale: CGFloat   // 1.0 = Normal, 1.2 = Zoomed In, 0.9 = ZoomedOut
    var videoOffsetX: CGFloat // -50 = Move Left, 50 = Move Right
    
    var videoOffsetY: CGFloat
}

// MARK: - 3. Mock Data Manager
class MockData {
    
    static let shared = MockData()
    
    // --- MOCK DATA ---
    
    var stats = PlayerStats(
        calories: 150,
        runTimeMinutes: 12,
        currentStreak: 4
    )
    
    // B. Characters Data
    var characters: [GameCharacter] = [
            // 1. Robot (Pink)
            GameCharacter(
                id: "c1",
                name: "Unit R-01",
                gifName: "c1_animated",
                staticImageName: "Character1 1",
                statsImageName: "Todays_stats_pink", // <-- Exact filename in Assets
                isSelected: false,
                isLocked: false,
                videoScale: 1.05,   // Zoom in
                videoOffsetX: -170,  // Shift left slightly
                videoOffsetY: 0
                
            ),
            GameCharacter(
                id: "c2",
                name: "Mechanic",
                gifName: "c2_animated",
                staticImageName: "Character1",
                statsImageName: "Todays_stats_orange", // <-- Exact filename in Assets
                isSelected: false,
                isLocked: false,
                videoScale: 1.05,   // No zoom
                videoOffsetX: -170,  // Shift left slightly
                videoOffsetY: -30
            ),
            GameCharacter(
                id: "c3",
                name: "Eco Ranger",
                gifName: "c3_animated",
                staticImageName: "Character5",
                statsImageName: "Todays_stats_green", // <-- Exact filename in Assets
                isSelected: true,
                isLocked: false,
                videoScale: 1.05,   // No zoom
                videoOffsetX: -170,  // Shift left slightly
                videoOffsetY: -30
            ),
            
            // ... Update the others similarly (Orange, Green, White) ...
        ]
    
    // --- HELPER FUNCTIONS ---
    
    func getSelectedCharacter() -> GameCharacter {
        if let selected = characters.first(where: { $0.isSelected }) {
            return selected
        }
        return characters[0]
    }
    
    // This is the logic your teammate will use later!
    func selectCharacter(id: String) -> Bool {
        // 1. Find the character they want
        guard let index = characters.firstIndex(where: { $0.id == id }) else {
            return false // Character not found
        }
        
        // 2. Check if locked
        if characters[index].isLocked {
            print("❌ Cannot select \(characters[index].name), it is locked!")
            return false // Failed to select
        }
        
        // 3. If unlocked, loop through ALL and flip the booleans
        for i in 0..<characters.count {
            if characters[i].id == id {
                characters[i].isSelected = true
                print("✅ Selected: \(characters[i].name)")
            } else {
                characters[i].isSelected = false
            }
        }
        return true // Success
    }
}
