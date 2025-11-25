import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    // You need to connect these in Storyboard!
    @IBOutlet weak var backgroundVideoView: LoopingVideoView!
    @IBOutlet weak var statsBackgroundView: UIImageView!
    
    // Stats Labels
    @IBOutlet weak var headerCaloriesLabel: UILabel!
    @IBOutlet weak var statsCaloriesLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // 1. Get Data from our "Brain"
            let currentCharacter = MockData.shared.getSelectedCharacter()
            let stats = MockData.shared.stats
            
            // --- 2. CONFIGURE VIDEO POSITION (New Part) ---
            // We pass the specific zoom and position for this character to the view
            backgroundVideoView.customScale = currentCharacter.videoScale
            backgroundVideoView.customOffsetX = currentCharacter.videoOffsetX
            backgroundVideoView.customOffsetY = currentCharacter.videoOffsetY
            
            // Force the view to update its layout immediately with these new numbers
            backgroundVideoView.setNeedsLayout()
            backgroundVideoView.layoutIfNeeded()
            
            // --- 3. PLAY VIDEO ---
            if let videoName = currentCharacter.gifName {
                backgroundVideoView.play(videoName: videoName)
            }
            
            // --- 4. UPDATE UI ---
            // Update Stats Box Color
            statsBackgroundView.image = UIImage(named: currentCharacter.statsImageName)
            
            // Update Text Labels
            headerCaloriesLabel.text = "\(stats.calories)"
            statsCaloriesLabel.text = "CALORIES : \(stats.calories)"
            runTimeLabel.text = "RUN TIME : \(stats.runTimeMinutes) Mins"
            streakLabel.text = "\(stats.currentStreak)"
        }
}
