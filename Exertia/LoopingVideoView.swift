import UIKit
import AVFoundation

class LoopingVideoView: UIView {
    
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    private var queuePlayer: AVQueuePlayer?
    
    // --- 1. NEW VARIABLES: Dynamic Control Properties ---
    // These defaults will be overwritten by your HomeViewController
    var customScale: CGFloat = 1.15
    var customOffsetX: CGFloat = -50
    var customOffsetY: CGFloat = 0
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            let videoAspectRatio: CGFloat = 16.0 / 9.0
            
            // Scale
            let newHeight = bounds.height * customScale
            let newWidth = newHeight * videoAspectRatio
            
            // Position X
            let newX: CGFloat = customOffsetX
            
            // Position Y (Center + Offset)
            let centeredY = (bounds.height - newHeight) / 2
            // We add your custom Y offset here
            let newY = centeredY + customOffsetY
            
            playerLayer.frame = CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
        }
    
    func play(videoName: String) {
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
            print("❌ Video not found: \(videoName)")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        queuePlayer = AVQueuePlayer(playerItem: item)
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: item)
        
        playerLayer.player = queuePlayer
        
        // Important: Keep gravity as 'resize' so we can manually control the aspect ratio above
        playerLayer.videoGravity = .resize
        
        playerLayer.backgroundColor = UIColor.black.cgColor
        self.backgroundColor = .black
        
        if playerLayer.superlayer == nil {
            layer.addSublayer(playerLayer)
        }
        
        queuePlayer?.isMuted = true
        queuePlayer?.play()
    }
    
    func stop() {
        queuePlayer?.pause()
    }
}
