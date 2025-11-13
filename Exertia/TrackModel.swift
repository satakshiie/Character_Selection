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
struct TimeAndCalories {
    var duration: Int // in seconds
    
    // Computed property: 10 minutes (600 seconds) = 80 calories
    // Ratio: 80 calories per 600 seconds = 0.1333 cal/sec
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
    
    // Set calories and update duration accordingly (maintaining 10min:80cal ratio)
    mutating func setCalories(_ targetCalories: Int) {
        // 80 cal = 600 seconds, so seconds = (calories * 600) / 80
        self.duration = (targetCalories * 600) / 80
    }
}

// MARK: - Track Struct
struct Track {
    let trackId: String
    let trackName: TrackName
    var isSelected: Bool
    var timeAndCalories: TimeAndCalories
    
    // Computed properties for convenience
    var displayName: String {
        return trackName.rawValue
    }
    
    var imageName: String {
        return trackName.imageName
    }
    
    // Static property for default time & calories shown in cells
    static let defaultTimeAndCalories = TimeAndCalories(duration: 0)
    
    init(trackId: String, trackName: TrackName, isSelected: Bool = false, timeAndCalories: TimeAndCalories = Track.defaultTimeAndCalories) {
        self.trackId = trackId
        self.trackName = trackName
        self.isSelected = isSelected
        self.timeAndCalories = timeAndCalories
    }
}

// MARK: - Track Manager (Optional - for managing track data)
class TrackManager {
    static let shared = TrackManager()
    
    private init() {}
    
    // Create default tracks
    func createDefaultTracks() -> [Track] {
        return [
            Track(trackId: "track_001", trackName: .planetX, isSelected: true),
            Track(trackId: "track_002", trackName: .planetY, isSelected: false),
            Track(trackId: "track_003", trackName: .warzone, isSelected: false)
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
