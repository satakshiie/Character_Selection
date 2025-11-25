//
//  HomeViewController.swift
//  BallGameDemo
//
//  Created by Ekansh Jindal on 07/11/25.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    // Background & Character
    @IBOutlet weak var backgroundVideoView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    // Stats Section
    @IBOutlet weak var statsBackgroundView: UIView!
    @IBOutlet weak var statsImageView: UIImageView!
    @IBOutlet weak var headerCaloriesLabel: UILabel!
    @IBOutlet weak var statsCaloriesLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    
    // MARK: - Video Player
    private var loopingVideoView: LoopingVideoView?
    
    // MARK: - Data
    // Reference to the shared game data singleton
    let gameData = GameData.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the video view
        setupVideoView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update UI with the selected character every time view appears
        // This ensures changes from CharacterSelectionViewController are reflected
        updateSelectedCharacterDisplay()
    }
    
    // MARK: - Setup
    
    private func setupVideoView() {
        // Create the looping video view
        loopingVideoView = LoopingVideoView()
        loopingVideoView?.translatesAutoresizingMaskIntoConstraints = false
        
        // Add it to the backgroundVideoView container
        if let videoView = loopingVideoView, let container = backgroundVideoView {
            container.addSubview(videoView)
            
            // Make it fill the container
            NSLayoutConstraint.activate([
                videoView.topAnchor.constraint(equalTo: container.topAnchor),
                videoView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                videoView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                videoView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
        }
    }
    
    // MARK: - UI Updates
    
    /// Updates the home screen to display the currently selected character
    func updateSelectedCharacterDisplay() {
        let selectedPlayer = gameData.getSelectedPlayer()
        
        // Update character image
        characterImageView?.image = UIImage(named: selectedPlayer.fullBodyImageName)
        
        // Update stats box image (the colored stats card)
        statsImageView?.image = UIImage(named: selectedPlayer.statsImageName)
        
        // Update character name if you have a label for it
        characterNameLabel?.text = selectedPlayer.name
        
        // Update stats labels
        updateStatsDisplay()
        
        // Update and play the video
        updateVideo(for: selectedPlayer)
        
        print("🏠 Home updated with: \(selectedPlayer.name)")
    }
    
    /// Updates the stats labels from GameData
    func updateStatsDisplay() {
        let stats = gameData.stats
        
        // Header calories (e.g., "150 Cal")
        headerCaloriesLabel?.text = "\(stats.calories) Cal"
        
        // Stats calories (same value, different label)
        statsCaloriesLabel?.text = "\(stats.calories)"
        
        // Run time (e.g., "12 min")
        runTimeLabel?.text = "\(stats.runTimeMinutes) min"
        
        // Streak (e.g., "4")
        streakLabel?.text = "\(stats.currentStreak)"
    }
    
    /// Updates the background video for the selected player
    private func updateVideo(for player: Player) {
        guard let videoView = loopingVideoView else { return }
        
        // Set video display properties
        videoView.customScale = player.videoScale
        videoView.customOffsetX = player.videoOffsetX
        videoView.customOffsetY = player.videoOffsetY
        
        // Play the video if available
        if let videoName = player.videoName {
            videoView.play(videoName: videoName)
            print("🎬 Playing video: \(videoName)")
        } else {
            videoView.stop()
            print("⏹️ No video for this character")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
