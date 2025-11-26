//
//  TrackModel.swift
//  Exertia
//
//  Created on 13/11/25.
//

import Foundation

// MARK: - Track Name Enum
enum TrackName: String, CaseIterable {
    case planetX = "Planet X"
    case planetY = "Planet Y"
    case warzone = "Warzone"
    
    var imageName: String {
        switch self {
        case .planetX:
            return "Track1"
        case .planetY:
            return "Track2"
        case .warzone:
            return "Track3"
        }
    }
}

// MARK: - Time & Calories Struct
// We keep this because your View Controller still needs it for the top section logic!
struct TimeAndCalories {
    var duration: Int // in seconds
    
    // Computed property: 10 minutes (600 seconds) = 80 calories
    var calories: Int {
        let caloriesPerSecond = 80.0 / 600.0
        return Int(Double(duration) * caloriesPerSecond)
    }
    
    // Helper to format duration as HH:MM:SS
    var formattedDuration: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        let seconds = duration % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // Helper to format calories
    var formattedCalories: String {
        return "\(calories) Kcal"
    }
    
    init(duration: Int) {
        self.duration = duration
    }
    
    // Convenience initializer for minutes
    init(minutes: Int) {
        self.duration = minutes * 60
    }
    
    // Set calories and update duration accordingly
    mutating func setCalories(_ targetCalories: Int) {
        self.duration = (targetCalories * 600) / 80
    }
}

// MARK: - Track Struct (UPDATED)
struct Track {
    let trackId: String
    let trackName: TrackName
    var isSelected: Bool
    
    // New: Description instead of Time/Calories
    let description: String
    
    // Computed properties
    var displayName: String {
        return trackName.rawValue
    }
    
    var imageName: String {
        return trackName.imageName
    }
    
    // Init
    init(trackId: String, trackName: TrackName, description: String, isSelected: Bool = false) {
        self.trackId = trackId
        self.trackName = trackName
        self.description = description
        self.isSelected = isSelected
    }
}

// MARK: - Track Manager
class TrackManager {
    static let shared = TrackManager()
    
    private init() {}
    
    // Create default tracks with descriptions
    func createDefaultTracks() -> [Track] {
        return [
            Track(
                trackId: "track_001",
                trackName: .planetX,
                description: "A scorched desert planet with shifting sands and ancient ruins.",
                isSelected: true
            ),
            Track(
                trackId: "track_002",
                trackName: .planetY,
                description: "A bioluminescent underwater world teeming with alien life.",
                isSelected: false
            ),
            Track(
                trackId: "track_003",
                trackName: .warzone,
                description: "A futuristic cyberpunk city battleground in the sky.",
                isSelected: false
            )
        ]
    }
    
    // Get track by ID
    func getTrack(by id: String, from tracks: [Track]) -> Track? {
        return tracks.first { $0.trackId == id }
    }
    
    // Update selection
    func updateSelection(for trackId: String, in tracks: inout [Track]) {
        for index in tracks.indices {
            tracks[index].isSelected = (tracks[index].trackId == trackId)
        }
    }
}
