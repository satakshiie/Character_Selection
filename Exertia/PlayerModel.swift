import Foundation
import UIKit

struct GameSession {
    let date: Date
    let durationMinutes: Int
    let caloriesBurned: Int
    let trackName: String
    let totalJumps: Int
    let totalCrouches: Int
    let characterImageName: String
}

struct PlayerStats {
    var calories: Int
    var runTimeMinutes: Int
    var currentStreak: Int
}

struct Player {
    let id: String
    let name: String
    let description: String
    let fullBodyImageName: String
    let thumbnailImageName: String
    let backgroundImageName: String
    let videoName: String?
    let videoScale: CGFloat
    let videoOffsetX: CGFloat
    let videoOffsetY: CGFloat
    var isSelected: Bool
    var isLocked: Bool
    
    var statsImageName: String {
        switch videoName {
        case "c1_animated": return "Todays_stats_pink"
        case "c2_animated": return "Todays_stats_orange"
        case "c3_animated": return "Todays_stats_green"
        default: return "Todays_stats_pink"
        }
    }
}

class GameData {
    static let shared = GameData()
    private init() {}
    
    var stats = PlayerStats(calories: 180, runTimeMinutes: 23, currentStreak: 4)

    var players: [Player] = [
        Player(id: "p1", name: "Glitch", description: "System error: Too cute.", fullBodyImageName: "character1", thumbnailImageName: "character1", backgroundImageName: "CharacterBg1", videoName: "c1_animated", videoScale: 1.05, videoOffsetX: -170, videoOffsetY: -30, isSelected: true, isLocked: false),
        Player(id: "p2", name: "Torque", description: "Forged in heavy metal.", fullBodyImageName: "character2", thumbnailImageName: "character2", backgroundImageName: "CharacterBg2", videoName: "c2_animated", videoScale: 1.05, videoOffsetX: -170, videoOffsetY: 0, isSelected: false, isLocked: false),
        Player(id: "p3", name: "Vanguard", description: "Shadows are the weapon.", fullBodyImageName: "character5", thumbnailImageName: "character5", backgroundImageName: "CharacterBg5", videoName: "c3_animated", videoScale: 1.05, videoOffsetX: -170, videoOffsetY: -30, isSelected: false, isLocked: false),
        Player(id: "p4", name: "Cipher", description: "Hacking reality's source code.", fullBodyImageName: "character4", thumbnailImageName: "character4", backgroundImageName: "CharacterBg4", videoName: "c1_animated", videoScale: 1.05, videoOffsetX: -170, videoOffsetY: 0, isSelected: false, isLocked: false),
        Player(id: "p5", name: "Sprout", description: "Blooming in the void.", fullBodyImageName: "character3", thumbnailImageName: "character3", backgroundImageName: "CharacterBg3", videoName: "c3_animated", videoScale: 1.05, videoOffsetX: -170, videoOffsetY: -30, isSelected: false, isLocked: false),
        Player(id: "p6", name: "Nova", description: "Starlight trapped in glass.", fullBodyImageName: "character6", thumbnailImageName: "character6", backgroundImageName: "CharacterBg6", videoName: "c2_animated", videoScale: 1.05, videoOffsetX: -170, videoOffsetY: -30, isSelected: false, isLocked: false)
    ]

    var gameHistory: [GameSession] = [
        GameSession(date: Date().addingTimeInterval(-86400 * 2), durationMinutes: 10, caloriesBurned: 80, trackName: "Planet X", totalJumps: 45, totalCrouches: 12, characterImageName: "character1"),
        GameSession(date: Date().addingTimeInterval(-86400), durationMinutes: 25, caloriesBurned: 200, trackName: "Planet Y", totalJumps: 120, totalCrouches: 40, characterImageName: "character4"),
        GameSession(date: Date(), durationMinutes: 12, caloriesBurned: 96, trackName: "Warzone", totalJumps: 55, totalCrouches: 20, characterImageName: "character2")
    ]
    
    var lastSession: GameSession? {
        return gameHistory.sorted(by: { $0.date < $1.date }).last
    }
    
    var personalBest: GameSession? {
        return gameHistory.max(by: { $0.caloriesBurned < $1.caloriesBurned })
    }
    
    func addSession(duration: Int, calories: Int, track: String, jumps: Int, crouches: Int) {
        let charImg = getSelectedPlayer().thumbnailImageName
        let newSession = GameSession(date: Date(), durationMinutes: duration, caloriesBurned: calories, trackName: track, totalJumps: jumps, totalCrouches: crouches, characterImageName: charImg)
        gameHistory.append(newSession)
        stats.calories += calories
        stats.runTimeMinutes += duration
    }

    func getSelectedPlayer() -> Player {
        return players.first(where: { $0.isSelected }) ?? players[0]
    }

    func getSelectedIndex() -> Int {
        return players.firstIndex(where: { $0.isSelected }) ?? 0
    }
    
    func selectPlayer(at index: Int) -> Bool {
        guard index >= 0 && index < players.count else { return false }
        if players[index].isLocked { return false }
        for i in 0..<players.count { players[i].isSelected = (i == index) }
        return true
    }
}
